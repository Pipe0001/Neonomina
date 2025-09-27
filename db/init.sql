-- Script de inicialización: crea tablas básicas para demostrar esquema
CREATE TABLE IF NOT EXISTS employees (
  id SERIAL PRIMARY KEY,
  identification_type VARCHAR(20),
  identification_number VARCHAR(50) UNIQUE NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(150),
  phone VARCHAR(50),
  address TEXT,
  hire_date DATE,
  end_date DATE,
  job_position VARCHAR(100),
  salary_base NUMERIC(12,0) NOT NULL,
  contract_type VARCHAR(50),
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS config_params (
  key TEXT PRIMARY KEY,
  value TEXT,
  updated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS payroll_periods (
  id SERIAL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'draft',
  created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS payrolls (
  id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
  period_id INT REFERENCES payroll_periods(id) ON DELETE CASCADE,
  days_worked INT DEFAULT 30,
  total_earnings NUMERIC(12,0),
  total_deductions NUMERIC(12,0),
  net_salary NUMERIC(12,0),
  generated_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS extra_hours (
  id SERIAL PRIMARY KEY,
  payroll_id INT REFERENCES payrolls(id) ON DELETE CASCADE,
  employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
  date_worked DATE,
  hours NUMERIC(6,2),
  hour_type VARCHAR(20),
  amount NUMERIC(12,0)
);

CREATE TABLE IF NOT EXISTS loans (
  id SERIAL PRIMARY KEY,
  employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
  principal NUMERIC(12,0),
  outstanding_balance NUMERIC(12,0),
  monthly_installment NUMERIC(12,0),
  monthly_interest_rate NUMERIC(5,4) DEFAULT 0.06,
  active BOOLEAN DEFAULT TRUE
);
