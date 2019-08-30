Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6CA3DD6
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfH3Sl4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 14:41:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62528 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727914AbfH3Sl4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 14:41:56 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UIbL1B190353
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 14:41:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uq0tssmx5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 14:41:55 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 30 Aug 2019 19:41:53 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 30 Aug 2019 19:41:50 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7UIfnI644957956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 18:41:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 162BCA4051;
        Fri, 30 Aug 2019 18:41:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A76CA4040;
        Fri, 30 Aug 2019 18:41:48 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 18:41:48 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 30 Aug 2019 14:41:47 -0400
In-Reply-To: <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19083018-0016-0000-0000-000002A4BEBE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19083018-0017-0000-0000-000033051A9E
Message-Id: <1567190507.10024.134.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Monty, Roberto]

On Thu, 2019-08-29 at 19:43 -0700, Lakshmi Ramasubramanian wrote:
> >> Without this patch set, to attest the clients one needs to maintain
> >> an "allowed list" of file hashes of all versions of all client binaries
> >> that are deployed on the clients in the enterprise.  That is a huge
> >> operational challenge in a large scale environment of clients with
> >> heterogenous builds. This also limits scalability and agility of
> >> rolling out frequent client binary updates.
> > 
> > The purpose of the ima-sig template, which includes the file signature
> > and header containing the keyid, is to avoid needing to maintain a
> > white list as you described.
> 
> If the service were to validate the signature in the ima-sig template, 
> it needs to have the hash of the file. Using the keyid in ima-sig pick 
> the key, calculate the signed hash and compare it with the signed hash 
> in the ima-sig template. Correct?
> 
> Or, it has to maintain the signed hash of the file and compare it with 
> the signed hash in the ima-sig template.
> 
> In both the cases, the service needs to have the hash or signed hash for 
> all the client files (for all versions of that file). This the 
> maintenance overhead we are trying to avoid.

No, the measurement list ima-sig template record contains both the
file hash and signature.  There's no need to maintain a white list of
either the file hashes or signed hashes.  All that is needed is the
set of permitted public keys (eg. keys on the trusted IMA keyring).

> 
> > The concern isn't on the client side, but the server side.  Once the
> > ability of including measurements of keys on the builtin and/or
> > secondary keyrings on the client side exists, the attestation servers
> > can start requiring it.  Providing a means of disabling it on the
> > client side doesn't address this problem.
> 
> But, wouldn't this problem exist for any new measure we add on the 
> client side? Why is it particularly an issue for measuring trusted keys?
> 
> > 
> > No, there is no need for maintaining a binary hash white list.  The
> > attestation server requires a set of trusted keys used to sign
> > software.
> > 
> > The only reason for measuring the keys on the builtin and/or secondary
> > keyrings is to prevent system owners from signing and running
> > applications on their own systems.
> > 
> > Since you obviously disagree, I'd really like to hear other people's thoughts.
> 
> Actually I am agreeing with you - the reason we want to measure the keys 
> in the trusted keyring is to ensure that the system binaries running on 
> the client are signed by trusted keys only.

The .builtin, .secondary, .ima, and .evm keyrings are all trusted
keyrings, based on a signature chain of trust rooted in the signed
Linux kernel.

Even though on the local system, files signed by the system owner
would be permitted, the attestation server would be able to control
access to whatever service.  For example, Trusted Network Connect
(TNC) could control network access.  By measuring the keys on the
builtin/secondary keyrings, that control is not based on who signed
the software package, but based on who signed the certificate of the
key that signed the software package.  My concern is how this level of
indirection could be abused.

> Please see below:
> 
> We let IMA verify the integrity of the system files on the client using 
> IMA key(s). The IMA key(s) are themselves signed by "Trusted Key(s)" - 
> unsigned IMA key or IMA key signed by keys not in the trusted keyring 
> are not even allowed to be added to the IMA keyring.
> 
> And, on the server we validate the "Trusted Keyring" contains only 
> known\trusted keys.
> 
> Through the above process - the server does not need to know the signed 
> file hash. It only needs to keep a list of trusted keys and verify if 
> the keys reported by the client is in that trusted keys set.
> 
> Please let me know if that answers your questions.

All of this would still be true, if you measured the keys on the
trusted IMA keyring, but without the level of indirection described
above.  Depending on your use case scenario, the problem with this
approach is maintaining a list of all the certificates that have been
signed by keys on the builtin, and if enabled, the secondary keyrings.

In the last LSS-NA BoF, Monty suggested, for a different use case, one
that needs to seal keys, measuring keys and extending a separate PCR.

Mimi

