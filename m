Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EFA523BFB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 19:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345885AbiEKRyL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbiEKRyK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 13:54:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3378B2397B8;
        Wed, 11 May 2022 10:54:06 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BHlT8l021278;
        Wed, 11 May 2022 17:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4SLmQyqszjt2p+ae6ineFhLKxmIsl1XWGzlafjcS7jo=;
 b=k6HBStuluXp9J96Lq1Yuf5gG0XOC2RQvy2cvEdwvtFRKAdsLnOBPBkSrL+qiZfyyjYcd
 s8YWeuX5mqm59AhPxB/asQE6lEBCOV8Z9n70BkwVVwr8RPUnqsblw6MkkY4veXErfiHi
 dYZjLy0ouWkFi8Jk+ECeCNmBZalBmnbh5dm9V9A7THAYiRRrJjH4Srp0+bjcHwhs5xU/
 RYfsVU2DF0jaT4DW4NQABwoJk9GkjC3sxllaeWpSMXI7TJhsT6MwYFVcpyc3E/xacJYB
 j40bGqQ76udrwKHs9JQmKGhjZF9cg3lTysYP0iLREjXw69vz16xnUfCWoapXyoLMrnDk kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0fedubtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:53:30 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BHfoq0014511;
        Wed, 11 May 2022 17:53:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0fedubt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:53:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BHXcE9010978;
        Wed, 11 May 2022 17:53:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fyrkk1qen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 17:53:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BHrPm548300534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 17:53:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD407A405C;
        Wed, 11 May 2022 17:53:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F50CA4054;
        Wed, 11 May 2022 17:53:24 +0000 (GMT)
Received: from sig-9-65-89-202.ibm.com (unknown [9.65.89.202])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 17:53:23 +0000 (GMT)
Message-ID: <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
Subject: Re: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 11 May 2022 13:53:23 -0400
In-Reply-To: <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
         <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XW9Ou39NMN7PD1z31LkZlt_gDovVfq9T
X-Proofpoint-ORIG-GUID: RelXZCHM90nzvBUJrnLsrxcR57rxZfMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jonathan,

On Wed, 2022-05-11 at 09:59 +0000, Jonathan McDowell wrote:
> On kexec file load Integrity Measurement Architecture (IMA) subsystem
> may verify the IMA signature of the kernel and initramfs, and measure
> it. The command line parameters passed to the kernel in the kexec call
> may also be measured by IMA. A remote attestation service can verify
> a TPM quote based on the TPM event log, the IMA measurement list, and
> the TPM PCR data. This can be achieved only if the IMA measurement log
> is carried over from the current kernel to the next kernel across
> the kexec call.
> 
> powerpc and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> ---
> v3:
>  - Rebase on tip/master

This patch doesn't apply to Linus' master branch.  Which tip/master
branch?  In the future, please use the git format-patch "--base=auto"
option.

>  - Pull ima_(free|get)_kexec_buffer into x86 code
>  - Push ifdefs into functions where possible
>  - Reverse fir tree variable declarations
>  - Fix section annotation on ima_free_kexec_buffer (__meminit)
>  - Only allocate ima_setup_data space when IMA_KEXEC is enabled

IMA_KEXEC only controls whether the current measurement list should be
carried across kexec, not restoring the previous measurement list.

> v2:
>  - Fix operation with EFI systems
> ---

> +++ b/include/linux/ima.h
> @@ -140,6 +140,9 @@ static inline int ima_measure_critical_data(const char *event_label,
>  
>  #endif /* CONFIG_IMA */
>  
> +int ima_free_kexec_buffer(void);
> +int ima_get_kexec_buffer(void **addr, size_t *size);

Wouldn't moving these function definitions here imply they are
implemented on all architectures or are using the version in
drivers/of/kexec.c.

thanks,

Mimi

