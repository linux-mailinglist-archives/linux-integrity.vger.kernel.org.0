Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61E3CB10
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfFKMXJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 08:23:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388669AbfFKMXJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 08:23:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BCM7X8006303
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 08:23:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t2b0rvdq8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jun 2019 08:23:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 11 Jun 2019 13:22:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 13:22:49 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BCMmgH42598536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 12:22:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 835E9A405C;
        Tue, 11 Jun 2019 12:22:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78683A405B;
        Tue, 11 Jun 2019 12:22:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.78])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 12:22:47 +0000 (GMT)
Subject: Re: [PATCH 0/2] [IMA] Measure public keys of BuiltIn Trusted Keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi <nramas@linux.microsoft.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jamorris@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Jordan Hand <jorhand@linux.microsoft.com>
Date:   Tue, 11 Jun 2019 08:22:36 -0400
In-Reply-To: <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
References: <f9f2a5ab-a880-7131-d0ca-fb3b72571478@linux.microsoft.com>
         <71cc3b9b-d045-8a69-5917-96b4c5654b16@linux.ibm.com>
         <0561ce44-f8f7-15f5-6eaf-fb97a785692a@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061112-0016-0000-0000-000002881692
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061112-0017-0000-0000-000032E54447
Message-Id: <1560255756.4464.111.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-07 at 10:15 -0700, Lakshmi wrote:
> On 6/7/19 7:14 AM, Ken Goldman wrote:
> 
> > 
> > Why is this important?  What is gained by measuring the keys on the
> > built-in keyring?  The IMA log already measures [a pointer to] the
> > IMA keys used for signature verification.  Why does the service care 
> > what keys were used to install the IMA keys?
> 
> By measuring the built-in keyring, the service knows whether or not the 
> key(s) in "IMA keyring" are indeed trusted or not. So while the IMA key 
> validates the file signatures on the client, the built-in key validates 
> the IMA key(s).
> 
> By knowing what keys were used to install the IMA key(s) the service 
> knows whether or not to trust the signature validation performed by IMA 
> on the client.
> 
> > 
> > I don't understand this reasoning.
> > 
> > To me, there is a difference between signed files and trusted files. 
> > E.g., an old version may be signed, but it is no longer trusted. >
> > In other words, the service wants to know all files that have run, not 
> > just whether they are signed.
> 
> The service will receive the entire IMA log - the entries that show what 
> system files were loaded, the IMA signature, etc. My change additionally 
> provides measurement on the signer (which key(s) were used to install 
> the keys in IMA keyring). Together this data enables the service to 
> determine whether the files on the client were signed and who the signer 
> is. The service can then decide whether the client is running files that 
> are trusted.
> 
> > 
> > Further, the service also wants to know files that were blocked from 
> > running, either because of no signature, a signature with an untrusted 
> > IMA key, or a bad signature.  I.e., the service needs the entire IMA 
> > log, not just the keys used to install the keys used to locally verify 
> > the signatures.
> 
> Like I have stated above, the change I am making is adding more data 
> (information on built-in keys) to what IMA log already provides".
> 
> My proposal is not to replace the current IMA log with just data on 
> "built-in keys".
> 
> Also, want to clarify that we do not want the service to also locally 
> verify the signatures. To do that the service needs to maintain the 
> signed file hashes of all the files and all the versions of each of 
> those files - That is an high overhead approach.
> 
> Instead, we let the client do the signature validation and on the 
> service just validate who signed those files.
> 
> > 
> > While the built-in keys may change less frequently that the IMA keys, 
> > both are likely to be stable.  I.e., is this proposal to provide an 
> > additional security benefit, or is it to improve performance?
> 
> The proposal enables the service to validate that the file signature of 
> the files on the client were created by "trusted signer". So it provides 
> additional security benefit and at the same time reduces the maintenance 
> overhead in the service - by enabling it to just keep track of "Known 
> good trusted keys" which change less frequently.
> 
> I hope I have answered all of your questions\concerns.

The design of IMA from the very beginning has been to allow the system
owner to decide which keys to trust.  This is the reason that the root
of trust pivots from the pre-boot keys to the keys embedded in the
Linux kernel.  When software packages contain both the file data and
file signatures, the system owner will be able to pick and choose
which public keys to sign and load onto the IMA keyring.

This patch set might not be limiting which public keys may be loaded
onto the builtin/secondary keyrings, but by virtue of including this
information in the measurement list, the attestation service (eg. TNC)
will be able to deny access.  IMA walks a fine line in enforcing and
measuring file integrity.  This patch set breaches that fine line and
by so doing, brings back the fears of trusted computing.

Mimi

