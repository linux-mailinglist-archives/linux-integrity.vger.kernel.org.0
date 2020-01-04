Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9240113050E
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 00:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgADXc7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 18:32:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgADXc7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 18:32:59 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 004NVsSg152037
        for <linux-integrity@vger.kernel.org>; Sat, 4 Jan 2020 18:32:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xaq7vrcxj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 04 Jan 2020 18:32:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 4 Jan 2020 23:32:56 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 4 Jan 2020 23:32:53 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 004NWplX42991780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Jan 2020 23:32:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD531A4054;
        Sat,  4 Jan 2020 23:32:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63853A405B;
        Sat,  4 Jan 2020 23:32:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.186.80])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  4 Jan 2020 23:32:51 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
Date:   Sat, 04 Jan 2020 18:32:50 -0500
In-Reply-To: <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
         <1577996725.5874.114.camel@linux.ibm.com>
         <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
         <1578007322.5874.128.camel@linux.ibm.com>
         <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010423-0008-0000-0000-0000034687DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010423-0009-0000-0000-00004A66C38C
Message-Id: <1578180770.5152.30.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_06:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001040224
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-03 at 13:27 -0500, Ken Goldman wrote:
> On 1/2/2020 6:22 PM, Mimi Zohar wrote:
> >> However, d-modsig is a hash.  How should a parser interpret a missing
> >> [file data] hash?  Under what conditions would that be legal / illegal /
> >> something to flag to an admin UI?
> > The "d-modsig" is the hash of the file without the appended signature.
> >   That hash is needed to verify the appended signature.  If there isn't
> > an appended signature, then there would be no reason for "d-modsig".
> 
> I'd like to make the leap from "no reason to" to what is permissible, 
> what a verifier would treat as legal or an error case.
> 
> E.g., should the IMA log specification say:
> 
> If the sig length is zero, the d-modsig length MUST be zero.
> 
> Or might it be a MAY, and then state
> 
> If the signature length is zero and the d-modsig length is non-zero,
> then the contents MUST be the same as the d-ng value.
> 
> What if the template has no 'd-ng', but it has a d-modsig?
> 
> What happens if the template has no 'sig'.  I.e. the sig
> is absent, then ... perhaps absent is the same as length zero?
> 
> Would we enforce that the d-ng hash algorithm MUST be the same as
> that of the d-modsig, or could they be different?
> 
> What if there are two 'sig' fields, one is zero and the other is not.
> 
> ~~
> 
> While the above are clearly not the normal case:
> 
> 1 - An attacker can use a custom IMA template to find a vulnerability in 
> the IMA implementation, or
> 
> 2 - An attacker could send a malformed log to a verifier.  To the 
> verifier, the received IMA log is unvalidated input, so the parser has 
> to be fastidious.

The "ima-modsig" template may include the "sig" and/or the "modsig"
fields.  As the "d-modsig" and "modsig" are tied together, either both
are defined or neither are defined.  The file hash ("d-ng") must
always exist.  The "sig" and "modsig" hash algorithms are independent
of each other.  They might or might not be the same.

Mimi

