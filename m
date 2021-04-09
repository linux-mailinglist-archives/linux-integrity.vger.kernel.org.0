Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6597035A610
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Apr 2021 20:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhDIStR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Apr 2021 14:49:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51448 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233332AbhDIStQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Apr 2021 14:49:16 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139IYFNs007375;
        Fri, 9 Apr 2021 14:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LVzrLC3YzT681sAknI1GQ3Z35WioB0LcG1pPl1zQXw4=;
 b=a7m8n//I20hjSiC+dD1CwBG3TZ8YJ2th0D90oANyxCa0GYQPUfvca/bNATCRq2n2dI0G
 DzC/cL3Q0lWo3HfjXN7fPTndDaG7pwdjRK6lVIlSRnITazp1CfchEoZjOZRp1IbxDB5j
 4DGt6EPinwtNk4GwTVvdo1qqiUpUCFdqK4w79uLEy7zcGqdlBpiyoxhKXqdG9n076iq2
 5SDU26t+ecyEh1HgIQ0kMoIRFGI53srV63PHnz0+X49HSrd8sMReJseOivuv/yxbnPhA
 KDYdY4d3/y/iRP7pgR0BHif3dMMErhP0e8m2Etr/YnmL4ocybwVO8iRYMZF5xgLyKy9F jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37t8fn24bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:48:53 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 139IZ9lh011994;
        Fri, 9 Apr 2021 14:48:53 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37t8fn24b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:48:53 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 139Ilsau016000;
        Fri, 9 Apr 2021 18:48:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 37rvbwap4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 18:48:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 139Imm5b63570412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Apr 2021 18:48:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA6F6AE04D;
        Fri,  9 Apr 2021 18:48:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3675BAE056;
        Fri,  9 Apr 2021 18:48:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.54.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Apr 2021 18:48:45 +0000 (GMT)
Message-ID: <b631513d0b5200577bb613ee23e2cdf7ad4bd175.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] ima: kernel build support for loading the kernel
 module signing key
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Date:   Fri, 09 Apr 2021 14:48:45 -0400
In-Reply-To: <20210409143507.191443-1-nayna@linux.ibm.com>
References: <20210409143507.191443-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B9lq_fuyFgfJO-nl6YsqnUnoHecksFB6
X-Proofpoint-ORIG-GUID: vHFzPe2KQAFXU1iElsm5sT_rJZmtQZ_-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_07:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090133
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-04-09 at 10:35 -0400, Nayna Jain wrote:
> Kernel modules are currently only signed when CONFIG_MODULE_SIG is enabled.
> The kernel module signing key is a self-signed CA only loaded onto the
> .builtin_trusted_key keyring.  On secure boot enabled systems with an arch
> specific IMA policy enabled, but without MODULE_SIG enabled, kernel modules
> are not signed, nor is the kernel module signing public key loaded onto the
> IMA keyring.
> 
> In order to load the the kernel module signing key onto the IMA trusted
> keyring ('.ima'), the certificate needs to be signed by a CA key either on
> the builtin or secondary keyrings. The original version of this patch set
> created and loaded a kernel-CA key onto the builtin keyring. The kernel-CA
> key signed the kernel module signing key, allowing it to be loaded onto the
> IMA trusted keyring.
> 
> However, missing from this version was support for the kernel-CA to sign the
> hardware token certificate. Adding that support would add additional
> complexity.
> 
> Since the kernel module signing key is embedded into the Linux kernel at
> build time, instead of creating and loading a kernel-CA onto the builtin
> trusted keyring, this version makes an exception and allows the 
> self-signed kernel module signing key to be loaded directly onto the 
> trusted IMA keyring.

Thanks,  Nayna.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
next-integrity

Mimi

