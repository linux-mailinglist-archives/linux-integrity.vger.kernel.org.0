Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC1A0ED0
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 03:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfH2BLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 21:11:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfH2BLb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 21:11:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T16u23085966
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 21:11:31 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up1m3my4n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 21:11:30 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 29 Aug 2019 02:11:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 02:11:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T1BPni42467452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 01:11:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 173714C046;
        Thu, 29 Aug 2019 01:11:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 312064C040;
        Thu, 29 Aug 2019 01:11:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 01:11:24 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com
Date:   Wed, 28 Aug 2019 21:11:23 -0400
In-Reply-To: <20190828002735.31025-1-nramas@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082901-0008-0000-0000-0000030E70BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082901-0009-0000-0000-00004A2CB290
Message-Id: <1567041083.6115.133.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Matthew Garrett]

On Tue, 2019-08-27 at 17:27 -0700, Lakshmi Ramasubramanian wrote:
> Created using linux v5.3.0-rc5
> 
> Motive:
> 
> Motive behind this patch set is to measure the public keys in
> the trusted keyring. If CONFIG_SECONDARY_TRUSTED_KEYRING is
> enabled then the trusted keys keyring is secondary_trusted_keys.
> Otherwise, the trusted keys keyring is builtin_trusted_keys.
> 
> Measurement of the trusted keys is an addition to
> the existing IMA measurements and not a replacement for it.
> 
> The measurement is enabled through the configuration value
> CONFIG_IMA_MEASURE_TRUSTED_KEYS. This configuration
> is turned OFF by default and have to opted in by the kernel
> builder.
> 
> Background:
> 
> Currently IMA measures file hashes and .ima signatures. IMA signatures
> are validated against keys in ".ima" keyring. If the kernel is built with
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY enabled,
> then all keys in ".ima" keyring must be signed by a key in
> ".builtin_trusted_keys" or ".secondary_trusted_keys" keyrings.
> 
> On systems with CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
> enabled, measuring keys in the  trusted keyring provides a mechanism
> to attest that the client's system binaries are indeed signed by signers
> that chain to known trusted keys.
> 
> Without this patch set, to attest the clients one needs to maintain
> an "allowed list" of file hashes of all versions of all client binaries
> that are deployed on the clients in the enterprise.  That is a huge
> operational challenge in a large scale environment of clients with
> heterogenous builds. This also limits scalability and agility of
> rolling out frequent client binary updates.

The purpose of the ima-sig template, which includes the file signature
and header containing the keyid, is to avoid needing to maintain a
white list as you described.
 
> 
> Current patch:
> 
> This patch set to measure the public keys in the trusted keys
> keyring is disabled by default and can be enabled with
> CONFIG_IMA_MEASURE_TRUSTED_KEYS. When this configuration is
> enabled, during boot IMA enumerates keys in the trusted keys
> keyring and measures them in the IMA log.
> 
> Questions and concerns raised by reviewers on this patch set:
> 
> Question 1:
> Is "Signed with a trusted key" equal to "Trusted file"?
> Doesn't the service need the hashes of the system files to determine
> whether a file is trusted or not?
> 
> "Signed with a trusted key" does not equal "Trusted"
> 
> Answer:
> Agree "Signed with a trusted key" may not equal "Trusted".
> To address this, the attesting service can maintain a small
> manageable set of bad hashes (a "Blocked list") and a list of
> trusted keys expected in client's trusted keys keyring.
> Using this data, the service can detect the presence of
> "Disallowed (untrusted) version of client binaries".
> 
> Question 2:
> Providing more data to the service (such as the keys in trusted keyring)
> empowers the service to deny access to clients (block clients).
> IMA walks a fine line in enforcing and measuring file integrity.
> This patchset breaches that fine line and in doing so brings back
> the fears of trusted computing.
> 
> Answer:
> Any new measurement we add in IMA will provide more data to service
> and can enable it to deny access to clients. It is not clear why
> this patch set would breach the fine line between measuring
> and enforcing.
> 
> Since this patch set is disabled by default and enabled through
> CONFIG_IMA_MEASURE_TRUSTED_KEYS, only those enterprises that
> require this new measurement can opt-in for it. Since it is disabled
> by default, it does not restrict the autonomy of independent users
> who are unaffected by attestation.

The concern isn't on the client side, but the server side.  Once the
ability of including measurements of keys on the builtin and/or
secondary keyrings on the client side exists, the attestation servers
can start requiring it.  Providing a means of disabling it on the
client side doesn't address this problem.

> 
> Question 3:
> IMA log already contains a pointer to the IMA keys used for signature
> verification. Why does the service need to care what keys were used
> to sign (install) the IMA keys? What is gained by measuring the keys
> in the trusted keyring?
> 
> Answer:
> To attest the clients using the current IMA log, service needs to maintain
> hashes of all the deployed versions of all the system binaries for their
> enterprise. This will introduce a very high operational overhead in
> a large scale environment of clients with heterogenous builds.
> This limits scalability and agility of rolling out frequent client
> binary updates.

No, there is no need for maintaining a binary hash white list.  The
attestation server requires a set of trusted keys used to sign
software.

The only reason for measuring the keys on the builtin and/or secondary
keyrings is to prevent system owners from signing and running
applications on their own systems.

Since you obviously disagree, I'd really like to hear other people's thoughts.

Mimi

> 
> On the other hand, with the current patch set, we will have IMA
> validate the file signature on the clients and the service validate
> that the IMA keys were installed using trusted keys.
> 
> This provides a chain of trust:
>     => IMA Key validates file signature on the client
>     => Key in the trusted keyring attests IMA key on the client
>     => Attestation service attests the trusted keys
>        reported by the client in the IMA log
> 
> This approach, therefore, would require the service to maintain
> a manageble set of trusted keys that it receives from a trusted source.
> And, verify if the clients only have keys from that set of trusted keys.
> 
> Question 4:
> Where will the attestation service receive the keys to validate against?
> 
> Answer:
> Attestation service will receive the keys from a trusted source such as
> the enterprise build services that provides the client builds.
> The service will use this set of keys to verify that the keys reported by
> the clients in the IMA log contains only keys from this trusted list.
> 
> Question 5:
> What is changing in the IMA log through this patch set?
> 
> Answer:
> This patch set does not remove any data that is currently included
> in the IMA log. It only adds more data to the IMA log - the data on
> keys in the trusted keyring
> 
> Lakshmi Ramasubramanian (1):
>   KEYS: Measure keys in trusted keyring
> 
>  certs/system_keyring.c            | 15 ++++++
>  include/keys/system_keyring.h     |  4 ++
>  include/linux/key.h               | 21 ++++++++
>  security/integrity/ima/Kconfig    | 14 ++++++
>  security/integrity/ima/ima_init.c | 84 +++++++++++++++++++++++++++++++
>  security/keys/keyring.c           | 63 +++++++++++++++++++++++
>  6 files changed, 201 insertions(+)
> 

