Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9BF0107693
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Nov 2019 18:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVRjt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Nov 2019 12:39:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbfKVRjs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Nov 2019 12:39:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMHdgPg113570
        for <linux-integrity@vger.kernel.org>; Fri, 22 Nov 2019 12:39:47 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wdqmjj0jr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 22 Nov 2019 12:39:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 22 Nov 2019 17:38:23 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Nov 2019 17:38:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAMHcJBh57737226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 17:38:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0F1AE045;
        Fri, 22 Nov 2019 17:38:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B0DAE051;
        Fri, 22 Nov 2019 17:38:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.167.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 22 Nov 2019 17:38:18 +0000 (GMT)
Subject: Re: IMA: Data included in the key measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     James Morris <jamorris@linuxonhyperv.com>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Fri, 22 Nov 2019 12:38:18 -0500
In-Reply-To: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
References: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112217-0016-0000-0000-000002CAEBA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112217-0017-0000-0000-0000332CB7FA
Message-Id: <1574444298.4793.202.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_03:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing David Howells, James Bottomley]

On Thu, 2019-11-21 at 08:17 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
>  >>> everything needed for verifying a signature is included in
>  >>> the key measurement.
> 
> Regarding the requirement you had stated above, I would like some 
> clarification.
> 
> When I started this change to measure keys through IMA, the use case we 
> had in mind was enabling an attestation service, for instance, to verify 
> if the client has only known good (trusted) keys - for example, in 
> keyrings such as ".builtin_trusted_keys", ".ima", etc.
> 
> On the client IMA verifies the signature of system binaries using keys 
> in the IMA keyring. And, if the config namely 
> CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled, 
> only keys signed by a built-in trusted key can be added to the IMA keyring.
> 
> An attestation service can keep a list of public keys of "known good 
> (trusted)" keys for various keyrings, and verify against the measurement 
> data provided by the client.

Right, that's true, assuming the attestation server is aware of all
possible public keys, which was the original reason you provided for
measuring the keys on the builtin trusted keyring, not the IMA
keyring.

> 
> To achieve the above we decided to include only the public key in the 
> key measurement buffer.
> 
> I would like to know what benefit we'd get by including "everything 
> needed for verifying a signature in the key measurement"?
> 
>  From testing point of view, if we have the certificate (like the .DER 
> file), we can validate the key measurement data in the IMA log.
> 
> Do you see a need to include more data or the entire cert for the 
> product code?

Your code has come a long way, since you first started.  Please don't
go back to what you originally intended/wanted to do.  Measuring keys
just on the builtin trusted keyring, as you did, was a non starter.
 It would never have been accepted upstream by me and doubtfully by
David.  The current measuring of keys is more generic and properly
isolated to IMA.  This is what I would have expected from the very
beginning.  Only now are the patches at the point, where there is
something to even discuss.

Now that you understand what patches should look like in order to be upstreamed, please look outside of your use-case scenario and think about the bigger picture.  Remember changing the "key" measurement in the future would cause a userspace regression.  So we need to fully understand what is needed, *before* it is upstreamed.  Yes, changing what is measured might change the IMA hook placement.

James Bottomley already started the discussion in this thread...

Mimi

