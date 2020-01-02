Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC6512F1C7
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 00:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgABXWM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jan 2020 18:22:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgABXWL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jan 2020 18:22:11 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 002N7RIh125195
        for <linux-integrity@vger.kernel.org>; Thu, 2 Jan 2020 18:22:10 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x88jwehy6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 Jan 2020 18:22:10 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 Jan 2020 23:22:08 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Jan 2020 23:22:05 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 002NLHHa13762912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jan 2020 23:21:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8747642041;
        Thu,  2 Jan 2020 23:22:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8C0842042;
        Thu,  2 Jan 2020 23:22:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.148.97])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jan 2020 23:22:02 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
Date:   Thu, 02 Jan 2020 18:22:02 -0500
In-Reply-To: <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
         <1577996725.5874.114.camel@linux.ibm.com>
         <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010223-4275-0000-0000-0000039435E4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010223-4276-0000-0000-000038A81993
Message-Id: <1578007322.5874.128.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-02_07:2020-01-02,2020-01-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714 mlxscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001020185
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-01-02 at 17:24 -0500, Ken Goldman wrote:
> On 1/2/2020 3:25 PM, Mimi Zohar wrote:
> > On Thu, 2020-01-02 at 15:10 -0500, Ken Goldman wrote:
> >> I'm trying to document the ima-modsig template and then write aparser.
> >> Can anyone help me complete it?
> >>
> >> 1 - What the implementation does today is interesting.  Even betterwould
> >> be what the implementation is permitted to do so that theparser will
> >> handle future changes.
> >>
> >> 2 - My understanding so far:
> >>
> >>       ima-modsig        is        d-ng | n-ng | sig | d-modsig |modsig
> >>
> >>       where (both have a prepended uint32_t length)
> >>
> >>       d-modsig            is    d-ng, filedata hash, omitting the
> >> appended modsig signature
> >>       modsig                is     pkcs7DER, appended signature
> >>
> >> My immediate issue is that the d-modsig should be a length +
> >> hashalgorithm + file data hash.  However, the length in my sample log
> >> issometimes zero, which I did not expect.
> >>
> >> I.e., it it legal for an ima-modsig template to contain an emptyd-modsig
> >> item?
> >>
> >> Can the modsig item also be empty?
> > 
> > Like the "sig" field in the "ima-sig" template, both the "d-modsig"
> > and "modsig" fields in the "ima-modsig" template may be empty.
> > 
> 
> I understand sig being empty is the file isn't signed.  Same with 
> modsig.  The verifier could flag that.
> 
> However, d-modsig is a hash.  How should a parser interpret a missing 
> [file data] hash?  Under what conditions would that be legal / illegal / 
> something to flag to an admin UI?

The "d-modsig" is the hash of the file without the appended signature.
 That hash is needed to verify the appended signature.  If there isn't
an appended signature, then there would be no reason for "d-modsig".

Mimi

