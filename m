Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242915B6D32
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 14:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiIMM0a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiIMM02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 08:26:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB259140DC;
        Tue, 13 Sep 2022 05:26:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DBptiN015687;
        Tue, 13 Sep 2022 12:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=KWhf+9y4Twe3kN6SJ/H/i8sS8Uc+GlmjIG+kRv57r1I=;
 b=GrO/dKEHEVbf6eO0tT/Q/k0GkxHeytvkDhTgSBQn8VcNowfkdXloY3YDdu2XO8wnykUQ
 b57qbRlxAnM/B0qmuDMUFjNHMt8HAZ9QHd9Z+9yu5slno3Cm6nQAFQWIg/fow8cympes
 W4Hg8KcL59Km6HS6+GDWiLIkCS1Tgti+c3Ae59AgbuBh5hcJcxWNHceed+SgYBx47Y5a
 /axFtvsO2zvk0h34ZnvGlZF6jjxdtd80RGW4Ye2S2xIxT9entckCNqxW5mo2u/uPqLyZ
 oPWCBLyLAALBtSbfGTGVNxuCxNFC5hn7v5CJjrF708qm0dYr4ebxDk6D6V2uhqnP643m 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjsc698fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:26:15 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DBtCoM026084;
        Tue, 13 Sep 2022 12:26:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjsc698fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:26:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DCLt2Y028932;
        Tue, 13 Sep 2022 12:26:13 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3jgj79buu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:26:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DCQD5822151670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 12:26:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72C577805F;
        Tue, 13 Sep 2022 12:40:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E807C7805E;
        Tue, 13 Sep 2022 12:40:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 12:40:32 +0000 (GMT)
Message-ID: <4308c2d0-94ae-8a65-e0c7-69270e31d447@linux.ibm.com>
Date:   Tue, 13 Sep 2022 08:26:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 02/10] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Content-Language: en-US
To:     Evan Green <evgreen@chromium.org>, linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, apronin@chromium.org,
        dlunev@google.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        corbet@lwn.net, jejb@linux.ibm.com,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220823152108.v2.2.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bgbPq4D_WT8GHfx8tSoSOqyBdOCVg8-u
X-Proofpoint-ORIG-GUID: AsknTBA13Kzga_E9gQcxwUrj9mePNgp0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130054
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/23/22 18:25, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Under certain circumstances it might be desirable to enable the creation
> of TPM-backed secrets that are only accessible to the kernel. In an
> ideal world this could be achieved by using TPM localities, but these
> don't appear to be available on consumer systems. An alternative is to
> simply block userland from modifying one of the resettable PCRs, leaving
> it available to the kernel. If the kernel ensures that no userland can
> access the TPM while it is carrying out work, it can reset PCR 23,
> extend it to an arbitrary value, create or load a secret, and then reset
> the PCR again. Even if userland somehow obtains the sealed material, it
> will be unable to unseal it since PCR 23 will never be in the
> appropriate state.
> 
> From: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> Matthew's original version of this patch is at:
> https://patchwork.kernel.org/patch/12096491/
> 
> Changes in v2:
>   - Fixed sparse warnings
> 
>   drivers/char/tpm/Kconfig          | 10 +++++++++
>   drivers/char/tpm/tpm-dev-common.c |  8 +++++++
>   drivers/char/tpm/tpm.h            | 21 +++++++++++++++++++
>   drivers/char/tpm/tpm1-cmd.c       | 35 +++++++++++++++++++++++++++++++
>   drivers/char/tpm/tpm2-cmd.c       | 22 +++++++++++++++++++
>   drivers/char/tpm/tpm2-space.c     |  2 +-
>   6 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f2..4483b61a428b11 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -211,4 +211,14 @@ config TCG_FTPM_TEE
>   	  This driver proxies for firmware TPM running in TEE.
>   
>   source "drivers/char/tpm/st33zp24/Kconfig"
> +
> +config TCG_TPM_RESTRICT_PCR
> +	bool "Restrict userland access to PCR 23"
> +	depends on TCG_TPM
> +	help
> +	  If set, block userland from extending or resetting PCR 23. This
> +	  allows it to be restricted to in-kernel use, preventing userland
> +	  from being able to make use of data sealed to the TPM by the kernel.
> +	  This is required for secure hibernation support, but should be left
> +	  disabled if any userland may require access to PCR23.
>   endif # TCG_TPM
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index dc4c0a0a512903..7a4e618c7d1942 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>   	priv->response_read = false;
>   	*off = 0;
>   
> +	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> +		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> +	else
> +		ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> +
> +	if (ret)
> +		goto out;
> +
>   	/*
>   	 * If in nonblocking mode schedule an async job to send
>   	 * the command return the size.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index a80b341d38eb8c..077c3ca0a127ba 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -229,6 +229,8 @@ void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
>   unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>   int tpm2_probe(struct tpm_chip *chip);
>   int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
> +int tpm_find_and_validate_cc(struct tpm_chip *chip, struct tpm_space *space,
> +			     const void *buf, size_t bufsiz);
>   int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
>   int tpm2_init_space(struct tpm_space *space, unsigned int buf_size);
>   void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
> @@ -244,4 +246,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
>   void tpm_bios_log_teardown(struct tpm_chip *chip);
>   int tpm_dev_common_init(void);
>   void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +#define TPM_RESTRICTED_PCR 23
> +
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +#else
> +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +
> +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +#endif
>   #endif
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 8ec743dec26544..318e75ae42fb85 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -845,3 +845,38 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	struct tpm_header *header = (struct tpm_header *)buffer;
> +	char len, offset;
> +	__be32 *pcr;
> +	int pos;
> +
> +	switch (be32_to_cpu(header->ordinal)) {
> +	case TPM_ORD_PCR_EXTEND:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +		pcr = (__be32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*pcr) == TPM_RESTRICTED_PCR)
> +			return -EPERM;

FYI: TPM 1.2 has transport sessions where the command is tunneled in an 
encrypted channel and this check could be circumvented...

