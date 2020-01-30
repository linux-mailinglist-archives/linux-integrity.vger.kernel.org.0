Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC614E583
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 23:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgA3W04 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 17:26:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725985AbgA3W0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 17:26:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UM6UaY107252
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 17:26:54 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xv7ctgy5s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 30 Jan 2020 17:26:54 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 30 Jan 2020 22:26:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 22:26:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UMQmCB23461998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 22:26:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48845AE051;
        Thu, 30 Jan 2020 22:26:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C162AE056;
        Thu, 30 Jan 2020 22:26:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.209.158])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 22:26:47 +0000 (GMT)
Subject: Re: [PATCH 0/8] ima: support stronger algorithms for attestation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com,
        james.bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 30 Jan 2020 17:26:46 -0500
In-Reply-To: <20200127170443.21538-1-roberto.sassu@huawei.com>
References: <20200127170443.21538-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20013022-4275-0000-0000-0000039C9631
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013022-4276-0000-0000-000038B0B55D
Message-Id: <1580423206.6104.19.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_07:2020-01-30,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Mon, 2020-01-27 at 18:04 +0100, Roberto Sassu wrote:
> IMA extends Platform Configuration Registers (PCRs) of the TPM to give a
> proof to a remote verifier that the measurement list contains all
> measurements done by the kernel and that the list was not maliciously
> modified by an attacker.
> 
> IMA was originally designed to extend PCRs with a SHA1 digest, provided
> with the measurement list, and was subsequently updated to extend all PCR
> banks in case a TPM 2.0 is used. Non-SHA1 PCR banks are not supposed to be
> used for remote attestation, as they are extended with a SHA1 digest padded
> with zeros, which does not increase the strength.
> 
> This patch set addresses this issue by extending PCRs with the digest of
> the measurement entry calculated with the crypto subsystem. The list of
> algorithms used to calculate the digest are taken from
> ima_tpm_chip->allocated_banks, returned by the TPM driver. The SHA1 digest
> is always calculated, as SHA1 still remains the default algorithm for the
> template digest in the measurement list.
> 
> This patch set also makes two additional modifications related to the usage
> of hash algorithms. First, since now the template digest for the default
> IMA algorithm is always calculated, this is used for hash collision
> detection, to check if there are duplicate measurement entries.
> 
> Second, it uses the default IMA hash algorithm to calculate the boot
> aggregate, assuming that the corresponding PCR bank is currently allocated.
> Otherwise, it finds the first PCR bank for which the crypto ID is known.
> IMA initialization fails only if no algorithm known to the crypto subsystem
> is found.
> 
> This patch set does not yet modify the format of the measurement list to
> provide the digests passed to the TPM. However, reconstructing the value of
> the quoted PCR is still possible for the verifier by calculating the digest
> on measurement data found in binary_runtime_measurements.

Thank you!  I'm still reviewing and testing the patches, but it is
really nicely written.

Mimi 

