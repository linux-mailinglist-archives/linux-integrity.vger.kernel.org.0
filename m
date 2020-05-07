Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0596F1C7FEA
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 04:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGCFe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 22:05:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgEGCFd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 22:05:33 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047242Xu083334;
        Wed, 6 May 2020 22:05:21 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4r5wfcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 22:05:21 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04722dhg012142;
        Thu, 7 May 2020 02:05:19 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 30s0g5m5wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 02:05:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0472479U64880896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 02:04:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57D6111C052;
        Thu,  7 May 2020 02:05:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83BEC11C04A;
        Thu,  7 May 2020 02:05:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.197.80])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 02:05:16 +0000 (GMT)
Message-ID: <1588817116.4624.51.camel@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/ima: fix secure boot rules in ima arch policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Date:   Wed, 06 May 2020 22:05:16 -0400
In-Reply-To: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
References: <1588342612-14532-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-06_09:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070007
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-01 at 10:16 -0400, Nayna Jain wrote:
> To prevent verifying the kernel module appended signature twice
> (finit_module), once by the module_sig_check() and again by IMA, powerpc
> secure boot rules define an IMA architecture specific policy rule
> only if CONFIG_MODULE_SIG_FORCE is not enabled. This, unfortunately, does
> not take into account the ability of enabling "sig_enforce" on the boot
> command line (module.sig_enforce=1).
> 
> Including the IMA module appraise rule results in failing the finit_module
> syscall, unless the module signing public key is loaded onto the IMA
> keyring.
> 
> This patch fixes secure boot policy rules to be based on CONFIG_MODULE_SIG
> instead.
> 
> Fixes: 4238fad366a6 ("powerpc/ima: Add support to initialize ima policy rules")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Thanks, Nayna.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
