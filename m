Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6623128FD
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 03:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBHCiI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Feb 2021 21:38:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBHCiH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Feb 2021 21:38:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1182WiTA169727;
        Sun, 7 Feb 2021 21:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=kJY/en/FMUlJF6XnpXszWOsBMbBfyNe3ALn9Q2aJtqY=;
 b=bbnqo+sZMYe8wmmX5A6/oaY7QEJOH6rVVvIhHH6DMa6aa1Qg0rcWnWBdxA61O0rh7Hl5
 WhcYWj937viWK2xeh9+91+4mg4SSW82oXjMyoH/qf3RJTYJoXBoLXDIn154nCBmrL7Q8
 my+pTQeW4nlPunbGE/9/ePQckOHiYsD407yNXQA6sZ6r+9RkcSeMAsURg6fqA4y9+Dwh
 TUoE3eGgBC1pUgxijkrASd2apq0r3BMJsEWo10MLzLD761arsA7YbIj1C8POzyQ1xks9
 5wAyZGQTXhnF50dhNjGTJ8ldkBz+V6Tj5438j+nEHVHYdSX+GSoapWYQ0DdH/KsN++Pj fw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36jq4y5hed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Feb 2021 21:37:24 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1182aKv1020902;
        Mon, 8 Feb 2021 02:37:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 36hqda1cxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 02:37:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1182bJtG46924142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 02:37:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD6D1A404D;
        Mon,  8 Feb 2021 02:37:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6F59A4040;
        Mon,  8 Feb 2021 02:37:18 +0000 (GMT)
Received: from sig-9-65-212-231.ibm.com (unknown [9.65.212.231])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 02:37:18 +0000 (GMT)
Message-ID: <dbd54f216aa92c2a0cf13bf99d2b3607dd3436ed.camel@linux.ibm.com>
Subject: Re: [PATCH] ima-evm-utils: Improve ima_measurement matching on busy
 system with >1 banks
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Date:   Sun, 07 Feb 2021 21:37:17 -0500
In-Reply-To: <20210205180739.676410-1-stefanb@linux.ibm.com>
References: <20210205180739.676410-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-07_14:2021-02-05,2021-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-02-05 at 13:07 -0500, Stefan Berger wrote:
> When a system is very busy with IMA taking measurements into more than
> one bank, then we often do not get the PCR 10 values of the sha1 bank
> that represents the same log entry as the reading of the PCR value of
> the sha256 bank. In other words, the reading of the PCR 10 value from
> the sha1 bank may represent the PCR 10 state at the time of the
> n-th entry in the log while the reading of the PCR 10 value from the
> sha256 bank may represent the state at the time of the (n+1)-th entry.
> The result currently is that the PCR measurements do not match and
> on a busy system the tool may not easily report a successful match.
> 
> This patch fixes this issue by separating the TPM bank comparison for
> each one of the banks being looked and using a bit mask for checking
> which banks have already been matched. Once the mask has become 0
> all PCR banks have been successfully matched.
> 
> A run on a busy system may result in the output as follows indicating
> PCR bank matches at the n-th entry for the sha1 bank and at a later
> entry, possibly n + 1 or n + 2 or so, for the sha256 bank. The
> output is interleaved with a match of the sha1 bank against 'padded
> matching'.
> 
> $ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
> Matched bank number 1.
> Matched padded bank number 1.
> Matched bank number 2.
> Matched per TPM bank calculated digest(s).
> 
> An idle system may report this here, indicating matches at the n-th
> entry.
> 
> $ evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/binary_runtime_measurements
> Matched bank number 1.
> Matched bank number 2.
> Matched per TPM bank calculated digest(s).
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.  The patch itself looks good.   However, the "Matched
bank number" debugging info should not be displayed at verbose level 0.
The output, below, is verbose level 1 (-v).  Instead of outputting the
bank matched, including the per bank matched measurement list entry
number would be more interesting.

10 ffdf6aaba2d153397467d9b536f957315cba9f22 ima-sig
sha256:264bc09abacd3d68041f0e1ca767f89cf9543c749684568b7dc747756ea2dc67
/usr/local/bin/evmctl
sha1: PCRAgg  10: 276b70c3b600f94e6f442e8f77e65bbf0586fd8c
sha1: TPM PCR-10: 276b70c3b600f94e6f442e8f77e65bbf0586fd8c
sha1 PCR-10: succeed         <=== include measurement entry number
sha256: PCRAgg  10:
4694ebe62c7df34e212894b175d24e1bfb3c2c16d9d5000852c3cc7492367acb
sha256: TPM PCR-10:
4694ebe62c7df34e212894b175d24e1bfb3c2c16d9d5000852c3cc7492367acb
sha256 PCR-10: succeed     <=== and here
Matched per TPM bank calculated digest(s).

thanks,

Mimi

