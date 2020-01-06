Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6439613165B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 17:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgAFQ4C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 11:56:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgAFQ4B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 11:56:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006Gdh7l117898
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 11:56:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xb8wfru11-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 11:56:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 Jan 2020 16:55:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 16:55:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006GttlU32440334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 16:55:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F4D94C059;
        Mon,  6 Jan 2020 16:55:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FDD74C040;
        Mon,  6 Jan 2020 16:55:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.222])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 16:55:54 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 06 Jan 2020 11:55:53 -0500
In-Reply-To: <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
         <1577996725.5874.114.camel@linux.ibm.com>
         <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
         <1578007322.5874.128.camel@linux.ibm.com>
         <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
         <1578180770.5152.30.camel@linux.ibm.com>
         <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
         <1578325821.5222.42.camel@linux.ibm.com>
         <7415a1ba-7fa9-4e86-f143-a3bc1bfdc80f@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010616-0016-0000-0000-000002DAECB3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010616-0017-0000-0000-0000333D60A4
Message-Id: <1578329753.5222.59.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_05:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=962 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001060148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 11:01 -0500, Ken Goldman wrote:
> On 1/6/2020 10:50 AM, Mimi Zohar wrote:
> >> I did have a question about the 'd-ng | sig | sig' template.  Is that an
> >> error or could a file be signed with e.g. both RSA-2048 and RSA-3072?
> >>
> >> Etc.  You can see where I'm going - precise rules for an IMA log verifier.
> > The "sig" field is the original IMA signature, stored as an extended
> > attribute.  If/when IMA fs-verity support is added, that signature
> > would require defining new digest and signature field types.  A
> > template with two "sig" fields doesn't make sense.
> 
> We cannot prevent an attacker from creating the custom template 'd-ng | 
> sig | sig', nor can we prevent an attacker from sending such a log to a 
> verifier.  Thus, we have to specify to a verifier what logs are valid 
> and what logs should be rejected and flagged as an attack.

There is only one security.ima extended attribute per file, at least
for the time being until IMA namespacing.  That would imply both "sig"
fields would have to be exactly the same.

Mimi

> 
> I.e., the verifier cannot assume that it will only receive logs that 
> make sense.  A secure parser has to handle any cleverly malformed event log.
> 
> There are 8-9 different possible IMA log fields, and we have to assume 
> the attacker will corrupt any or all of them.

