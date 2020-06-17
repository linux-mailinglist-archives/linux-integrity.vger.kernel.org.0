Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02021FD181
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgFQQFA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 12:05:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgFQQE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 12:04:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HG2qZl196099;
        Wed, 17 Jun 2020 12:04:50 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6hbv7js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 12:04:50 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HFxccs015659;
        Wed, 17 Jun 2020 16:04:49 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 31q8rybsgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 16:04:49 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HG4nJP16253770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 16:04:49 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 394C5AC05B;
        Wed, 17 Jun 2020 16:04:49 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B683AC059;
        Wed, 17 Jun 2020 16:04:49 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jun 2020 16:04:49 +0000 (GMT)
Subject: Re: Stalled /dev/tpmr0 when context size increases to support RSA
 3072 bit keys
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
Message-ID: <4cd7345d-78ac-c5fd-e50f-36cf0bed8489@linux.ibm.com>
Date:   Wed, 17 Jun 2020 12:04:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/16/20 6:30 PM, Stefan Berger wrote:
> I am upgrading libtpms's TPM 2 to support RSA 3072 keys (increase 
> context size to 2680 bytes) and wanted to test an upgrade from 
> previous version (0.7.2) which only supports RSA 2048 keys to this 
> newer version (git master). I tried to run this with clevis setting up 
> automatic decryption via TPM 2, but it doesn't work and it seems the 
> issue is due to a stall of /dev/tpmr0 that doesn't respond anymore.
>
>
> [...]
>
> It's stuck polling on /dev/tpmrm0.
>
>    Any ideas?

It has something to do with the offset parameter and the PAGE_SIZE as a 
limit.

[  842.288597] *offset=0
[  842.295345] *offset=2692
[  842.301011] body_size=2692, *offset=2692, buf_size=4096
[  842.301584] tpm tpm0: tpm2_save_context: out of backing storage
[  842.305463] tpm tpm0: tpm2_commit_space: error -12
[  850.793691] tpm tpm0: A TPM error (459) occurred flushing context

This here fixes it. Any suggestion for a proper fix?

Does it concatenate contexts into this PAGE_SIZE'd buffer?


diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..b5e7307c7ecd 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -40,7 +40,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, 
struct tpm_space *space)

  int tpm2_init_space(struct tpm_space *space)
  {
-       space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+       space->context_buf = kzalloc(3*PAGE_SIZE, GFP_KERNEL);
         if (!space->context_buf)
                 return -ENOMEM;

@@ -123,6 +123,7 @@ static int tpm2_save_context(struct tpm_chip *chip, 
u32 handle, u8 *buf,
         unsigned int body_size;
         int rc;

+printk(KERN_INFO "*offset=%u\n", *offset);
         rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, 
TPM2_CC_CONTEXT_SAVE);
         if (rc)
                 return rc;
@@ -147,6 +148,7 @@ static int tpm2_save_context(struct tpm_chip *chip, 
u32 handle, u8 *buf,

         body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
         if ((*offset + body_size) > buf_size) {
+printk(KERN_INFO "body_size=%u, *offset=%u, buf_size=%u\n", body_size, 
*offset, buf_size);
                 dev_warn(&chip->dev, "%s: out of backing storage\n", 
__func__);
                 tpm_buf_destroy(&tbuf);
                 return -ENOMEM;
@@ -311,7 +313,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct 
tpm_space *space, u8 *cmd,
                sizeof(space->context_tbl));
         memcpy(&chip->work_space.session_tbl, &space->session_tbl,
                sizeof(space->session_tbl));
-       memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
+       memcpy(chip->work_space.context_buf, space->context_buf, 
3*PAGE_SIZE);
         memcpy(chip->work_space.session_buf, space->session_buf, 
PAGE_SIZE);

         rc = tpm2_load_space(chip);
@@ -487,12 +489,13 @@ static int tpm2_save_space(struct tpm_chip *chip)
         int i;
         int rc;

+       printk(KERN_INFO "ARRAY_SIZE(space->context_tbl) = %lu\n", 
ARRAY_SIZE(space->context_tbl));
         for (i = 0, offset = 0; i < ARRAY_SIZE(space->context_tbl); i++) {
                 if (!(space->context_tbl[i] && ~space->context_tbl[i]))
                         continue;

                 rc = tpm2_save_context(chip, space->context_tbl[i],
-                                      space->context_buf, PAGE_SIZE,
+                                      space->context_buf, 3*PAGE_SIZE,
                                        &offset);
                 if (rc == -ENOENT) {
                         space->context_tbl[i] = 0;
@@ -530,6 +533,7 @@ int tpm2_commit_space(struct tpm_chip *chip, struct 
tpm_space *space,
         struct tpm_header *header = buf;
         int rc;

+printk(KERN_INFO "%s:%d\n", __func__, __LINE__);
         if (!space)
                 return 0;

@@ -557,7 +561,7 @@ int tpm2_commit_space(struct tpm_chip *chip, struct 
tpm_space *space,
                sizeof(space->context_tbl));
         memcpy(&space->session_tbl, &chip->work_space.session_tbl,
                sizeof(space->session_tbl));
-       memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
+       memcpy(space->context_buf, chip->work_space.context_buf, 
3*PAGE_SIZE);
         memcpy(space->session_buf, chip->work_space.session_buf, 
PAGE_SIZE);

         return 0;

