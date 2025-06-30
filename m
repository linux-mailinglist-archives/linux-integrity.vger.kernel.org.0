Return-Path: <linux-integrity+bounces-6570-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E620AEDD61
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 14:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A33F189AFE0
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Jun 2025 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF77285C9D;
	Mon, 30 Jun 2025 12:47:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B8238151;
	Mon, 30 Jun 2025 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287659; cv=none; b=n3JuCIGxAy4NkW2AFcnMmKPdd9haRjIlEKCv2nRWMYPaZtirKsfe7l5mBbbRjWC+7HTXOsf3GkyVHgBTsuFYrz0wswXkLjRDs/bk5m1kOlEY9bM7lPNH+60ZQJ6XyzAmnZw/qWSgKvxgmd59s4UUUQVxbaQmWBT11/CAph+fSbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287659; c=relaxed/simple;
	bh=RI4JfP4uMiyhmak/PvP3vrFP+lLcCWroER12Jm2IaVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LLNW/TG3Gms4g/rqSLxRItSoH5ILQ76oUVylqQG/RC1rm9/acrIISsPfhDELU7i8PgKVVlRM0QQIF+FDoKW5a1K6uxB35zR4mQJ9ZaFz7IUO+KRa55Y6ayGCVGGO4Zdvjp5/oitBL3tP+nxhi7fIwUvSLkHt6BM7DhLgWQ0RF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bW5Tt2fXZz13Mjw;
	Mon, 30 Jun 2025 20:45:06 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A78181402CF;
	Mon, 30 Jun 2025 20:47:33 +0800 (CST)
Received: from huawei.com (10.67.174.33) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 20:47:32 +0800
From: GONG Ruiqi <gongruiqi1@huawei.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-kernel@vger.kernel.org>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	Lu Jialin <lujialin4@huawei.com>, <gongruiqi1@huawei.com>
Subject: [PATCH -next RFC 0/4] IMA Root of Trust (RoT) Framework
Date: Mon, 30 Jun 2025 20:59:24 +0800
Message-ID: <20250630125928.765285-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemg100016.china.huawei.com (7.202.181.57)

Currently, the IMA subsystem can only use TPM as the Root of Trust
(RoT) device, and its coding is tightly coupled with TPM operations.

        ┌──────────┐    ┌───────────┐
       ┌┴─────────┐│   ┌┴──────────┐│
       │ Programs ├┘   │ Libraries ├┘
       └────┬─────┘    └────┬──────┘                       User
─ ─ ─ ─ ─ ─ │ ─ ─ ─ ─ ─ ─ ─ │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
            └────────┬──────┘                              Kernel
                     ▼
  ┌────────────────────────────────────┐  ┌────────────────┐
  │              IMA Hooks             │  │                │
  │ (file read, executed, mmapped etc) │  │                │
  └──────────────────┬─────────────────┘  │      IMA       │
                     ▼                    │ Initialization │
  ┌────────────────────────────────────┐  │                │
  │        IMA Measurement List        │  │                │
  └──────────────────┬─────────────────┘  └────┬───────┬───┘
               extend│      calc_boot_aggregate│   init│
                     ▼                         ▼       ▼
  ┌────────────────────────────────────────────────────────┐
  │                    TPM Device Driver                   │
  └─────────────────────────────┬──────────────────────────┘
                                │
─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
                                ▼                          Hardware
                     ┌──────────────────┐
                     │    TPM Device    │
                     └──────────────────┘

In recent years, new scenarios such as Confidential Computing have
emerged, requiring IMA to use various new RoT devices proposed by
different vendors, such as Intel TDX[1] and Huawei VirtCCA[2]. To make
it easier for these devices to be integrated into the IMA subsystem, it
is necessary to decouple TPM specific code from IMA, while abstracting
IMA's configuration and operation to RoT devices into multiple
independent interfaces, ultimately forming an IMA RoT device framework.
This framework abstracts away the underlying details of various RoT
devices for IMA, and each type of RoT devices can be "plugged in" and
utilized by IMA simply via implementing the framework interfaces.

            ┌──────────┐    ┌───────────┐
           ┌┴─────────┐│   ┌┴──────────┐│
           │ Programs ├┘   │ Libraries ├┘
           └────┬─────┘    └────┬──────┘                        User
─ ─ ─ ─ ─ ─ ─ ─ │ ─ ─ ─ ─ ─ ─ ─ │ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─
                └───────┬───────┘                               Kernel
                        ▼
     ┌────────────────────────────────────┐  ┌────────────────┐
     │              IMA Hooks             │  │                │
     │ (file read, executed, mmapped etc) │  │                │
     └──────────────────┬─────────────────┘  │      IMA       │
                        ▼                    │ Initialization │
     ┌────────────────────────────────────┐  │                │
     │        IMA Measurement List        │  │                │
     └──────────────────┬─────────────────┘  └────┬───────┬───┘
                  extend│      calc_boot_aggregate│   init│
                        ▼                         ▼       ▼
     ┌────────────────────────────────────────────────────────┐
     │                        IMA RoT                         │
     │                       Framework                        │
     └───────────────────────────┬────────────────────────────┘
         ┌───────────────┬───────┴─────────┬─────────────────┐
         ▼               ▼                 ▼                 ▼
┌────────────────┐ ┌────────────┐ ┌──────────────────┐ ┌────────────┐
│ VirtCCA Driver │ │ TPM Driver │ │ Intel TDX Driver │ │ xxx Driver │
└────────┬───────┘ └─────┬──────┘ └────────┬─────────┘ └─────┬──────┘
         │               │                 │                 │
─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─ ─ ─ ─ ─│─ ─ ─ ─ ─
         │               │                 │                 │  Hardware
         ▼               ▼                 ▼                 ▼
┌────────────────┐ ┌────────────┐ ┌──────────────────┐ ┌────────────┐
│ VirtCCA Device │ │ TPM Device │ │ Intel TDX Device │ │ xxx Device │
└────────────────┘ └────────────┘ └──────────────────┘ └────────────┘

This patch set provides an implementation of the aforementioned IMA RoT
framework, which can facilitate easier adaptation for new devices such
as Intel TDX and Huawei VirtCCA, as well as the classic TPM, to be an
RoT that IMA can utilize to maintain system's integrity.

[1]: Reference for Intel TDX with IMA:
https://www.intel.cn/content/www/cn/zh/developer/articles/community/runtime-integrity-measure-and-attest-trust-domain.html

[2]: Reference for Huawei VirtCCA:
https://gitee.com/openeuler/kernel/blob/OLK-6.6/Documentation/virtcca/virtcca.txt


GONG Ruiqi (4):
  ima: rot: Introduce basic framework
  ima: rot: Prepare TPM as an RoT
  ima: rot: Make RoT kick in
  ima: rot: Involve per-RoT default PCR index

 security/integrity/ima/Kconfig            |  12 +-
 security/integrity/ima/Makefile           |   3 +-
 security/integrity/ima/ima.h              |  11 +-
 security/integrity/ima/ima_api.c          |   4 +-
 security/integrity/ima/ima_crypto.c       | 139 +++----------------
 security/integrity/ima/ima_fs.c           |   4 +-
 security/integrity/ima/ima_init.c         |  14 +-
 security/integrity/ima/ima_main.c         |   4 +-
 security/integrity/ima/ima_queue.c        |  39 ++----
 security/integrity/ima/ima_rot.c          | 108 +++++++++++++++
 security/integrity/ima/ima_rot.h          |  42 ++++++
 security/integrity/ima/ima_template.c     |   2 +-
 security/integrity/ima/ima_template_lib.c |   4 +-
 security/integrity/ima/ima_tpm.c          | 154 ++++++++++++++++++++++
 security/integrity/ima/ima_tpm.h          |  19 +++
 15 files changed, 388 insertions(+), 171 deletions(-)
 create mode 100644 security/integrity/ima/ima_rot.c
 create mode 100644 security/integrity/ima/ima_rot.h
 create mode 100644 security/integrity/ima/ima_tpm.c
 create mode 100644 security/integrity/ima/ima_tpm.h

-- 
2.25.1


