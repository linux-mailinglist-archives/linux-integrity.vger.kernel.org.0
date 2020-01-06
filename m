Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB6131699
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 18:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAFRSg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 12:18:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgAFRSf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 12:18:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006H2PCW123272
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 12:18:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8nya6m2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 12:18:34 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 Jan 2020 17:18:32 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 17:18:30 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006HHgps40698228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 17:17:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB0EA4040;
        Mon,  6 Jan 2020 17:18:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D84A4051;
        Mon,  6 Jan 2020 17:18:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.222])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 17:18:28 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 06 Jan 2020 12:18:27 -0500
In-Reply-To: <7958a6d2-d7ca-98b2-55b7-def1675fb674@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
         <1577996725.5874.114.camel@linux.ibm.com>
         <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
         <1578007322.5874.128.camel@linux.ibm.com>
         <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
         <1578180770.5152.30.camel@linux.ibm.com>
         <7958a6d2-d7ca-98b2-55b7-def1675fb674@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010617-0008-0000-0000-00000346F486
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010617-0009-0000-0000-00004A6733A0
Message-Id: <1578331107.5222.77.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_05:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=2 bulkscore=0 adultscore=0 mlxlogscore=956
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Roberto]

On Mon, 2020-01-06 at 09:27 -0500, Ken Goldman wrote:
> On 1/4/2020 6:32 PM, Mimi Zohar wrote:
> > The "ima-modsig" template may include the "sig" and/or the "modsig"
> > fields.  As the "d-modsig" and "modsig" are tied together, either both
> > are defined or neither are defined.  The file hash ("d-ng") must
> > always exist.
> That's clear for the predefined (is there a formal term for them?) 
> templates.  How would this be specified when IMA permits custom templates?

"predefined" is fine, or "builtin".

> 
> E.g., I can create a template 'modsig', I have the signature but not the 
> file data hash.  I can create a template 'd-modsig' that has the file
> data hash but no signature.

That should be flagged as an error.

> 
> With custom templates, the attacker can create any IMA log, and the 
> parser has to handle it.
> 
> Note:  When you say "either both are defined or neither is defined", 
> this may be enforced by the official IMA code.  However, the attacker is 
> free to modify the IMA code to send any log it likes.  The parser has to 
> know what to do.

An attacker shouldn't be able to spoof the PCR quote.  As previously
discussed, the verifier should first walk the measurement list
calculating the PCR values.  Only if the PCRs match, should the
verifier attempt to parse the individual template data records.

> 
> That is, an event log specification (which I'm trying to write) has to 
> state precisely that the dependencies are and what should be rejected. 
> For example, it might say (if this is corrct):
> 
> 1 - If d-modsig is present, modsig MUST be present.  Else error.
> 2 - If modsig is present, d-modsig MUST be present.

Yes

> 3 - If ???, d-ng MUST be present.

Templates were designed to be extensible, allowing new fields to be
defined and combined.  I can't say definitively that there will never
be a case when the "d-ng" field isn't needed, but at least for the
moment that is the case.  Perhaps with IMA fs-verity support, only a
digest and signature, based on the merkle tree file hash will be
needed.

Mimi

