Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00771DB7FE
	for <lists+linux-integrity@lfdr.de>; Wed, 20 May 2020 17:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETPVl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 May 2020 11:21:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbgETPVk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 May 2020 11:21:40 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04KF236S117475;
        Wed, 20 May 2020 11:21:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cb1svdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 11:21:36 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04KF2bDO120435;
        Wed, 20 May 2020 11:21:35 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cb1svbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 11:21:35 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04KFG3Ho031648;
        Wed, 20 May 2020 15:21:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 313xdhsjvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 May 2020 15:21:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04KFLUdZ54854044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 15:21:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEFA652057;
        Wed, 20 May 2020 15:21:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.138.181])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 33FAC5204E;
        Wed, 20 May 2020 15:21:30 +0000 (GMT)
Message-ID: <1589988089.5111.280.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima-evm-utils: Add support for Intel TSS2 for PCR
 reading
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     patrick@puiterwijk.org, linux-integrity@vger.kernel.org
Cc:     pbrobinson@redhat.com
Date:   Wed, 20 May 2020 11:21:29 -0400
In-Reply-To: <CAJweMda2DC+L10v5T7G_FCF5LZxwQMp4x4LYdAdi4kTO2bFAiw@mail.gmail.com>
References: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
         <CAJweMda2DC+L10v5T7G_FCF5LZxwQMp4x4LYdAdi4kTO2bFAiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-20_10:2020-05-20,2020-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-24 at 15:04 -0800, patrick@puiterwijk.org wrote:
> From: Patrick Uiterwijk <patrick@puiterwijk.org>
> 
> This patch makes it possible to use the Intel TSS2 for getting
> PCR values from the SHA1/SHA256 banks on a TPM2.
> It is somewhat naive as it doesn't use the multi-PCR selection
> that TSS2 is capable of, that is for a future patch.
> 
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>

Thanks, Patrick.  There was a missing include in pcr_tsspcrread.c,
which I've included.  This patch is now in the ima-evm-utils next-
testing branch.  I'd appreciate some Review/Test tags for at least the
pcr_tss.c aspect.

IMA support for extending the TPM 2.0 banks with the hash appropriate
algorithm will, hopefully, be upstreamed in Linux 5.8  The new
"boot_aggregate" test calculates a per TPM bank "boot_aggregate"
value.  One of which should match the "boot_aggregate" value in the
IMA measurement list.

Please note that the new "boot_aggregate" test[1] can be run as root,
which accesses the exported TPM securityfs event log, or as a user,
which uses the sample TPM 2.0 sample event log and associated IMA
measurement list.  To calculate the "boot_aggregate" based on the
sample TPM 2.0 event log, requires starting a software TPM and
initializing it based on the TPM event log.  The code currently
initializes the TPM using tsseventextend.

Testing ima-evm-utils support for multiple crypto and TSS packages
requires building a matrix.  As I'm new to travis, the travis code is
in the next-testing-travis branch, but will not be upstreamed at this
point.  To prevent running the "boot_aggregate" test when using the
tpm2-tss, the software TPM is not installed.

Mimi

[1] VERBOSE=1 make check TESTS=boot_aggregate.test
[2] tsseventextend" -tpm -if "${BINARY_BIOS_MEASUREMENTS}" -v

