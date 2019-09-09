Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC545AD9FD
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfIINba (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 09:31:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbfIINba (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 09:31:30 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89DNBNr100394
        for <linux-integrity@vger.kernel.org>; Mon, 9 Sep 2019 09:31:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uwqjn8eev-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Sep 2019 09:31:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 9 Sep 2019 14:31:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 14:31:24 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89DVNbK39518302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 13:31:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4473911C04C;
        Mon,  9 Sep 2019 13:31:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 147EB11C050;
        Mon,  9 Sep 2019 13:31:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.93])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 13:31:21 +0000 (GMT)
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 09 Sep 2019 09:31:21 -0400
In-Reply-To: <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
         <1567041083.6115.133.camel@linux.ibm.com>
         <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
         <1567190507.10024.134.camel@linux.ibm.com>
         <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090913-0008-0000-0000-0000031326F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090913-0009-0000-0000-00004A318A95
Message-Id: <1568035881.4614.347.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-09-03 at 08:54 -0700, Lakshmi Ramasubramanian wrote:
> On 8/30/19 11:41 AM, Mimi Zohar wrote:
> 
> > No, the measurement list ima-sig template record contains both the
> > file hash and signature.  There's no need to maintain a white list of
> > either the file hashes or signed hashes.  All that is needed is the
> > set of permitted public keys (eg. keys on the trusted IMA keyring).
> 
> You are right - Thanks for the info.
> 
> > Even though on the local system, files signed by the system owner
> > would be permitted, the attestation server would be able to control
> > access to whatever service.  For example, Trusted Network Connect
> > (TNC) could control network access.  By measuring the keys on the
> > builtin/secondary keyrings, that control is not based on who signed
> > the software package, but based on who signed the certificate of the
> > key that signed the software package.  My concern is how this level of
> > indirection could be abused.
> Since the signer of certificate of the key that signed the software 
> package changes much less frequently compared to the certificate of the 
> key used to sign the software package, the operational overhead on the 
> server side is significantly reduced.
> 
> I understand there is another level of indirection here. But I am also 
> not clear how this can be abused.

The remote attestation server could gate any service based on the
certificate signer.  The first gated service, based on this feature,
will probably be network access (eg. TNC).  If/when this feature is
upstreamed, every company, including financial institutes,
organizations, and governments will become THE certificate signer for
their organization, in order to limit access to their network and
systems.  Once that happens, how long will it be until the same
feature will be abused and used to limit the individual's ability to
pick and choose which applications may run on their systems.[1]

Mimi

[1] Refer to Richard Stallman's last paragraph https://www.gnu.org/phi
losophy/can-you-trust.en.html

> > All of this would still be true, if you measured the keys on the
> > trusted IMA keyring, but without the level of indirection described
> > above.  Depending on your use case scenario, the problem with this
> > approach is maintaining a list of all the certificates that have been
> > signed by keys on the builtin, and if enabled, the secondary keyrings.
> 
> Yes - that is the issue we are trying to avoid. Especially since the 
> list of signing certificates can grow faster than the signer of those 
> certificates (that are present in the builtin/secondary keyrings)
> 
> > In the last LSS-NA BoF, Monty suggested, for a different use case, one
> > that needs to seal keys, measuring keys and extending a separate PCR.
> Thanks for the info. I will gather more information on this one.
> 
>   -lakshmi
> 

