using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.IO;

namespace Assembler.Parser.Tests
{
    [TestClass()]
    public class AssemblyInterpreterTests
    {
        [TestMethod()]
        public void Ejemplo1Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo1.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 1");
            }
        }

        [TestMethod()]
        public void Ejemplo2Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo2.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 2");
            }
        }

        [TestMethod()]
        public void Ejemplo3Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo3.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 3");
            }
        }

        [TestMethod()]
        public void Ejemplo4Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo4.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 4");
            }
        }

        [TestMethod()]
        public void Ejemplo5Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo5.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 5");
            }
        }

        [TestMethod()]
        public void Ejemplo6Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo6.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 6");
            }
        }

        [TestMethod()]
        public void Ejemplo7Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo7.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 7");
            }
        }

        [TestMethod()]
        public void Ejemplo8Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo8.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 8");
            }
        }

        [TestMethod()]
        public void Ejemplo9Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo9.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 9");
            }
        }

        [TestMethod()]
        public void Ejemplo10Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo10.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 5");
            }
        }

        [TestMethod()]
        public void Ejemplo11Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo11.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 11");
            }
        }

        [TestMethod()]
        public void Ejemplo12Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo12.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 12");
            }
        }

        [TestMethod()]
        public void Ejemplo13Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo13.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 13");
            }
        }

        [TestMethod()]
        public void Ejemplo14Test()
        {
            try
            {
                string text = File.ReadAllText("Ejemplo14.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en ejemplo 14");
            }
        }

        [TestMethod()]
        public void EjemploPrueba()
        {
            try
            {
                string text = File.ReadAllText("prueba.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en prueba");
            }
        }

        [TestMethod()]
        public void EjemploSort()
        {
            try
            {
                string text = File.ReadAllText("sort.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en sort");
            }
        }

        [TestMethod()]
        public void EjemploPromedio()
        {
            try
            {
                string text = File.ReadAllText("promedio.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en promedio");
            }
        }

        [TestMethod()]
        public void EjemploModa()
        {
            try
            {
                string text = File.ReadAllText("moda.txt");
                AssemblyInterpreter interpreter = new AssemblyInterpreter();
                interpreter.Interpret(text);
                Assert.IsTrue(true);
            }
            catch
            {
                Assert.Fail("Hubo un error en moda");
            }
        }
    }
}