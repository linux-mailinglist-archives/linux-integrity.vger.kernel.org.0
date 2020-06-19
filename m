Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715E20190C
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2020 19:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387565AbgFSRGG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Jun 2020 13:06:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733192AbgFSRGF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Jun 2020 13:06:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JH26TO135016;
        Fri, 19 Jun 2020 13:06:01 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31rthadku2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 13:06:01 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JH5cvv020528;
        Fri, 19 Jun 2020 17:06:00 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 31rdtff4fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 17:06:00 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JH5wAi26607904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 17:05:58 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02B086A051;
        Fri, 19 Jun 2020 17:06:00 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1506A04D;
        Fri, 19 Jun 2020 17:05:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 17:05:59 +0000 (GMT)
Subject: Re: Stalled /dev/tpmr0 when context size increases to support RSA
 3072 bit keys
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <b404211d-f540-d2bd-eaf6-2b616bebb899@linux.ibm.com>
 <4cd7345d-78ac-c5fd-e50f-36cf0bed8489@linux.ibm.com>
Message-ID: <178deb28-63aa-e1b5-2a87-29345affeb02@linux.ibm.com>
Date:   Fri, 19 Jun 2020 13:05:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4cd7345d-78ac-c5fd-e50f-36cf0bed8489@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_19:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/17/20 12:04 PM, Stefan Berger wrote:
> On 6/16/20 6:30 PM, Stefan Berger wrote:
>> I am upgrading libtpms's TPM 2 to support RSA 3072 keys (increase 
>> context size to 2680 bytes) and wanted to test an upgrade from 
>> previous version (0.7.2) which only supports RSA 2048 keys to this 
>> newer version (git master). I tried to run this with clevis setting 
>> up automatic decryption via TPM 2, but it doesn't work and it seems 
>> the issue is due to a stall of /dev/tpmr0 that doesn't respond anymore.
>>
>>
>> [...]
>>
>> It's stuck polling on /dev/tpmrm0.
>>
>>    Any ideas?
>
> It has something to do with the offset parameter and the PAGE_SIZE as 
> a limit.
>
> [  842.288597] *offset=0
> [  842.295345] *offset=2692
> [  842.301011] body_size=2692, *offset=2692, buf_size=4096
> [  842.301584] tpm tpm0: tpm2_save_context: out of backing storage
> [  842.305463] tpm tpm0: tpm2_commit_space: error -12
> [  850.793691] tpm tpm0: A TPM error (459) occurred flushing context
>
> This here fixes it. Any suggestion for a proper fix?
>
> Does it concatenate contexts into this PAGE_SIZE'd buffer? 


This may be a better workable patch that needs to apply to many previous 
kernel versions:


  drivers/char/tpm/tpm-chip.c   |  2 +-
  drivers/char/tpm/tpm.h        |  2 ++
  drivers/char/tpm/tpm2-space.c | 12 ++++++++----
  3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8c77e88012e9..d32a173117b8 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -386,7 +386,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
      chip->cdev.owner = THIS_MODULE;
      chip->cdevs.owner = THIS_MODULE;

-    chip->work_space.context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+    chip->work_space.context_buf = kzalloc(TPM_SPACE_SIZE, GFP_KERNEL);
      if (!chip->work_space.context_buf) {
          rc = -ENOMEM;
          goto out;
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 0fbcede241ea..5f34187da858 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -36,6 +36,8 @@
  #define TPM_NUM_DEVICES        65536
  #define TPM_RETRY        50

+#define TPM_SPACE_SIZE          (3 * 4096)
+
  enum tpm_timeout {
      TPM_TIMEOUT = 5,    /* msecs */
      TPM_TIMEOUT_RETRY = 100, /* msecs */
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..493900008fa2 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -40,7 +40,7 @@ static void tpm2_flush_sessions(struct tpm_chip *chip, 
struct tpm_space *space)

  int tpm2_init_space(struct tpm_space *space)
  {
-    space->context_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+    space->context_buf = kzalloc(TPM_SPACE_SIZE, GFP_KERNEL);
      if (!space->context_buf)
          return -ENOMEM;

@@ -123,6 +123,7 @@ static int tpm2_save_context(struct tpm_chip *chip, 
u32 handle, u8 *buf,
      unsigned int body_size;
      int rc;

+printk(KERN_INFO "*offset=%u\n", *offset);
      rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
      if (rc)
          return rc;
@@ -147,6 +148,7 @@ static int tpm2_save_context(struct tpm_chip *chip, 
u32 handle, u8 *buf,

      body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
      if ((*offset + body_size) > buf_size) {
+printk(KERN_INFO "body_size=%u, *offset=%u, buf_size=%u\n", body_size, 
*offset, buf_size);
          dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
          tpm_buf_destroy(&tbuf);
          return -ENOMEM;
@@ -311,7 +313,7 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct 
tpm_space *space, u8 *cmd,
             sizeof(space->context_tbl));
      memcpy(&chip->work_space.session_tbl, &space->session_tbl,
             sizeof(space->session_tbl));
-    memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
+    memcpy(chip->work_space.context_buf, space->context_buf, 
TPM_SPACE_SIZE);
      memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);

      rc = tpm2_load_space(chip);
@@ -487,12 +489,13 @@ static int tpm2_save_space(struct tpm_chip *chip)
      int i;
      int rc;

+    printk(KERN_INFO "ARRAY_SIZE(space->context_tbl) = %lu\n", 
ARRAY_SIZE(space->context_tbl));
      for (i = 0, offset = 0; i < ARRAY_SIZE(space->context_tbl); i++) {
          if (!(space->context_tbl[i] && ~space->context_tbl[i]))
              continue;

          rc = tpm2_save_context(chip, space->context_tbl[i],
-                       space->context_buf, PAGE_SIZE,
+                       space->context_buf, TPM_SPACE_SIZE,
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
-    memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
+    memcpy(space->context_buf, chip->work_space.context_buf, 
TPM_SPACE_SIZE);
      memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);

      return 0;


