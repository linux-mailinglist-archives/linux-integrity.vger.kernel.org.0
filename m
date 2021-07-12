Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66ABA3C64AE
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhGLUH2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 16:07:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233299AbhGLUH1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 16:07:27 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CK3xDI017522;
        Mon, 12 Jul 2021 16:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=OqvVUjngvShKdsSy4qHCHrp6wWSaZa76CtkQynx/fx8=;
 b=JRU17Y1E5RnZYC9VY4HFjZJbLMBBVxmDEMjb7r7ACqJ1lLrSvL60HTjBvNfgF7raPzGb
 YG8JMTQljGiQtSZAv8teupWwzaq55dn0U9sgTAN0aETUhHLTDK1I7BZY8XmLKvTQ0dmK
 bfIBQsH2UEgJabWe9r/QqNSxg1GNa1zBXawtTQep1KiRdTEh38DxRCg8cb7o94OzRcAC
 6BzShQIz8WHvp9EBokFQCjaKVcQzv3VLk/w5qbk+2XHPcQ5/RTw5j85m7XTKS0lV7CL0
 UiwB5dhi/LBaUzCSEIsD00ZOy23cavnIABdCzfmYBAgfIFBr5vVhAbc4Gy3RAw+Rt14s vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkw4jts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 16:04:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CK4Bnv018514;
        Mon, 12 Jul 2021 16:04:36 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrkw4js8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 16:04:36 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CK3OcV000954;
        Mon, 12 Jul 2021 20:04:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 39q2th8xkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 20:04:33 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CK2RRT28508566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 20:02:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7E1AE051;
        Mon, 12 Jul 2021 20:04:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F00BAE04D;
        Mon, 12 Jul 2021 20:04:30 +0000 (GMT)
Received: from sig-9-65-203-86.ibm.com (unknown [9.65.203.86])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jul 2021 20:04:30 +0000 (GMT)
Message-ID: <b2dab0c5a7f67f337257ddf63dc58134c36ca4f9.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v8 0/3] ima-evm-utils: Add --keyid option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 12 Jul 2021 16:04:29 -0400
In-Reply-To: <20210712054448.2471236-1-vt@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s5bhyYcitCF7d6A2t6VQhBG-4RB8NiP5
X-Proofpoint-ORIG-GUID: QeTV-X7O08pPn5bEnCujAb_G34w8pbWb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_11:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107120139
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> Allow user to set signature's keyid using `--keyid' option. Keyid should
> correspond to SKID in certificate. When keyid is calculated using SHA-1
> in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> certificate (the way public key is presented to the kernel), thus making
> signatures not verifiable. This may happen when certificate is using non
> SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> As a last resort user may specify arbitrary keyid using the new option.
> Certificate filename could be used instead of the hex number with
> `--keyid-from-cert' option. And, third option is to read keyid from the
> cert appended to the key file.
> 
> These commits create backward incompatible ABI change for libimaevm,
> thus soname should be incremented on release.

I can't seem to apply either of your patch sets using "git am", only
manually using "patch -p0 <  <mbox>".    This hasn't been a problem in
the past.  Did you do something differently?

thanks,

Mimi

