Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA48844C0B
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfFMTWU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 15:22:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbfFMTWT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 15:22:19 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DJM46u141835
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 15:22:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3ufr2ps1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jun 2019 15:22:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 13 Jun 2019 20:22:16 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 20:22:13 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DJMCse40698120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 19:22:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7190A4C05A;
        Thu, 13 Jun 2019 19:22:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E9514C052;
        Thu, 13 Jun 2019 19:22:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.91])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 19:22:11 +0000 (GMT)
Subject: Re: [PATCH V8 1/3] Define a new IMA hook to measure the boot
 command line arguments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Thu, 13 Jun 2019 15:22:00 -0400
In-Reply-To: <20190612221549.28399-2-prsriva02@gmail.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061319-0008-0000-0000-000002F38B78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061319-0009-0000-0000-000022609300
Message-Id: <1560453720.4805.46.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130143
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

Patches titles in the subject line need to be prefixed with the
subsystem, in this case "ima: ".

On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> This patch adds support in ima to measure kexec cmdline args
> during soft reboot(kexec_file_load).

Based on the patch title, the word "ima" is redundant.  Patch
descriptions are suppose to be written in the third person. "This
patch adds" is unnecessary.  Please review section 3 "Describe your
changes" in Documentation/process/submitting-patches.rst.

> 
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the ima log.
> - A new func policy KEXEC_CMDLINE is defined to control the
>  measurement.[Suggested by Mimi]
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>


> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index fd9b01881d17..98e351e13557 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -292,6 +292,13 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> +	/* only incase of KEXEC_CMDLINE, inode is NULL */
> +	if (func == KEXEC_CMDLINE) {
> +		if ((rule->flags & IMA_FUNC) &&
> +			(rule->func == func) && (!inode))

Thank you for fixing the other formatting issues.  Here's another one.
 Is checking !inode needed?

Mimi

> +			return true;
> +		return false;
> +	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
>  		return false;
> 

