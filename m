Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0790020A874
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407606AbgFYW5I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 18:57:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406272AbgFYW5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 18:57:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PMWx4Z075491;
        Thu, 25 Jun 2020 18:56:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vx91cbxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 18:56:51 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PMg9vL113179;
        Thu, 25 Jun 2020 18:56:51 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vx91cbxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 18:56:50 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PMsuGx018908;
        Thu, 25 Jun 2020 22:56:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 31uusps3jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 22:56:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PMtQeH59376086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 22:55:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C61AE055;
        Thu, 25 Jun 2020 22:56:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBF77AE053;
        Thu, 25 Jun 2020 22:56:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 22:56:44 +0000 (GMT)
Message-ID: <1593125804.27152.426.camel@linux.ibm.com>
Subject: Re: [PATCH 12/12] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Date:   Thu, 25 Jun 2020 18:56:44 -0400
In-Reply-To: <20200623003236.830149-13-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
         <20200623003236.830149-13-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_19:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> Take the properties of the kexec kernel's inode and the current task
> ownership into consideration when matching a KEXEC_CMDLINE operation to
> the rules in the IMA policy. This allows for some uniformity when
> writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> and KEXEC_CMDLINE operations.
> 
> Prior to this patch, it was not possible to write a set of rules like
> this:
> 
>  dont_measure func=KEXEC_KERNEL_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_INITRAMFS_CHECK obj_type=foo_t
>  dont_measure func=KEXEC_CMDLINE obj_type=foo_t
>  measure func=KEXEC_KERNEL_CHECK
>  measure func=KEXEC_INITRAMFS_CHECK
>  measure func=KEXEC_CMDLINE
> 
> The inode information associated with the kernel being loaded by a
> kexec_kernel_load(2) syscall can now be included in the decision to
> measure or not
> 
> Additonally, the uid, euid, and subj_* conditionals can also now be
> used in KEXEC_CMDLINE rules. There was no technical reason as to why
> those conditionals weren't being considered previously other than
> ima_match_rules() didn't have a valid inode to use so it immediately
> bailed out for KEXEC_CMDLINE operations rather than going through the
> full list of conditional comparisons.

This makes a lot of sense.

<snip>
 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index c1583d98c5e5..82acd66bf653 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -731,13 +731,15 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @eventname: event name to be used for the buffer entry.
>   * @func: IMA hook
>   * @pcr: pcr to extend the measurement
> + * @inode: inode associated with the object being measured (NULL for KEY_CHECK)
>   * @keyring: keyring name to determine the action to be performed
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
>  void process_buffer_measurement(const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *keyring)
> +				int pcr, struct inode *inode,
> +				const char *keyring)
>  {

The file descriptor is passed as the first arg to
process_measurement().  Sorry for the patch churn, but could we do the
same for process_buffer_measurements.  As much as possible lets keep
them in same.

thanks,

Mimi
