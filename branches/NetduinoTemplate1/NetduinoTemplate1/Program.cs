﻿using System;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using SecretLabs.NETMF.Hardware.Netduino;
using System.Threading;

namespace InfraredDetector
{
    public class Program
    {
        public enum TokenState
        {
            LISTEN = 0,
            STARTBYTE = 1,
            MESSAGE = 2,
            ENDBYTE = 3,
            READ = 4

        }
        public enum Gun
        {
            PUSSY = 0,
            MAN = 1
        }
        public static TokenState state;
        public static int sleep = 20;
        public static string message = "10110100";
        public static string message2 = "10111000";
        public static Gun playerGun = Gun.PUSSY;
        public static Microsoft.SPOT.Hardware.PWM infraredOut;
        public static bool powerUp = false;
        public static DateTime d;
        public static DateTime c;
        public static int count;
        public static void Main()
        {
            count = 0;
            d = DateTime.Now;
            c = DateTime.Now;

            InputPort digitalIn = new InputPort(Pins.GPIO_PIN_D3, false, Port.ResistorMode.Disabled);
            OutputPort powerUpPort = new OutputPort(Pins.GPIO_PIN_D0, false);

            infraredOut = new Microsoft.SPOT.Hardware.PWM(PWMChannels.PWM_PIN_D6, 38000, .5, true);
            InterruptPort sender = new InterruptPort(Pins.GPIO_PIN_D10, false, Port.ResistorMode.PullUp, Port.InterruptMode.InterruptEdgeLow);
            sender.OnInterrupt += sender_OnInterrupt;
            state = TokenState.LISTEN;
            string message = "";


            while (true)
            {
                getPowerUp();
                powerUpPort.Write(powerUp);
                switch (state)
                {
                    case TokenState.LISTEN:
                        GetListenByte(digitalIn);
                        break;
                    case TokenState.STARTBYTE:
                        GetStartByte(digitalIn);
                        break;
                    case TokenState.MESSAGE:
                        message = GetMessage(digitalIn);
                        break;
                    case TokenState.ENDBYTE:
                        GetEndByte(digitalIn);
                        break;
                    case TokenState.READ:
                        Debug.Print(String.Concat(message, "\n"));
                        state = TokenState.LISTEN;
                        message = "";
                        break;
                }
            }
        }
        public static void getPowerUp()
        {
            if (c.AddMilliseconds(500) < DateTime.Now)
            {
                c = DateTime.Now;
                Random r = new Random();
                var random = r.Next() % 10;
                if (random > 5)
                {
                    powerUp = true;
                    playerGun = Gun.MAN;
                }
                else
                {
                    powerUp = false;
                    playerGun = Gun.PUSSY;
                }
            }
        }
        static void sender_OnInterrupt(uint data1, uint data2, DateTime time)
        {
            if (d.AddMilliseconds(250) < DateTime.Now)
            {
                d = DateTime.Now;
                count++;
                if (playerGun == Gun.PUSSY)
                {
                    Debug.Print(count.ToString() + "interupt" + "Pussy Gun");
                    SendMessage(infraredOut, message);
                }
                else
                {
                    Debug.Print(count.ToString() + "interupt" + "Man Gun");
                    SendMessage(infraredOut, message2);
                }
            }
        }
        public static void GetListenByte(InputPort digitalIn)
        {
            while (true)
            {
                //Found our first one...now wait for a 0
                if (!digitalIn.Read())
                {
                    var d = DateTime.Now;
                    while (digitalIn.Read() && d.AddMilliseconds(500) < DateTime.Now )
                    {
                        //noop
                    }
                }
                state = TokenState.STARTBYTE;
                Thread.Sleep(sleep);
                break;
            }
        }
        public static void GetStartByte(InputPort digitalIn)
        {
            //Better be a 1
            if (!digitalIn.Read())
            {
                Thread.Sleep(sleep);
                //And still a 1
                if (!digitalIn.Read())
                {
                    Thread.Sleep(sleep);
                    state = TokenState.MESSAGE;
                    return;
                }
                state = TokenState.LISTEN;
            }
            state = TokenState.LISTEN;
        }
        public static string GetMessage(InputPort digitalIn)
        {
            var message = "";
            DateTime startTime;

            if (!digitalIn.Read())
            {
                message += "1";
            }
            else
            {
                message += "0";
            }

            Thread.Sleep(sleep);

            if (!digitalIn.Read())
            {
                message += "1";
            }
            else
            {
                message += "0";
            }
            Thread.Sleep(sleep);
            if (message == "11" || message == "00")
            {
                state = TokenState.LISTEN;
                message = "";
                return "";
            }

            state = TokenState.ENDBYTE;
            return message;
        }
        public static void GetEndByte(InputPort digitalIn)
        {
            //Better be a 0
            if (digitalIn.Read())
            {
                Thread.Sleep(sleep);
                //And still a 0
                if (digitalIn.Read())
                {
                    Thread.Sleep(sleep);
                    state = TokenState.READ;
                    return;
                }
                state = TokenState.LISTEN;
            }
            state = TokenState.LISTEN;
        }

        public static void SendMessage(PWM infraredOut, string message)
        {
            foreach (char c in message)
            {
                SendBit(infraredOut, c);

            }
        }


        public static void SendBit(PWM infraredOut, char c)
        {

            if (c == '1')
            {
                var startTime = DateTime.Now;
                infraredOut.Start();
                while (startTime.AddMilliseconds(sleep) > DateTime.Now)
                {

                }
                infraredOut.Stop();
            }
            else
            {
                var startTime = DateTime.Now;
                while (startTime.AddMilliseconds(sleep) > DateTime.Now)
                {

                }
                startTime = DateTime.Now;
            }
        }


    }
}