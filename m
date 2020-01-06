Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96A75131554
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 16:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgAFPua (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 10:50:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1292 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbgAFPu3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 10:50:29 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 006FgRm2138298
        for <linux-integrity@vger.kernel.org>; Mon, 6 Jan 2020 10:50:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xapd5chx9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jan 2020 10:50:27 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 Jan 2020 15:50:25 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 15:50:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 006FnZPZ16187712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 15:49:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E1F4C044;
        Mon,  6 Jan 2020 15:50:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 155B84C046;
        Mon,  6 Jan 2020 15:50:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.222])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 15:50:21 +0000 (GMT)
Subject: Re: Spec needed for ima-modsig template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        Ken Goldman <kgoldman@us.ibm.com>
Date:   Mon, 06 Jan 2020 10:50:21 -0500
In-Reply-To: <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
References: <e2e2863e-9908-5156-8aca-32f8e583f0e3@linux.ibm.com>
         <1577996725.5874.114.camel@linux.ibm.com>
         <584145d6-bf12-e5ee-972f-91283aa66f74@linux.ibm.com>
         <1578007322.5874.128.camel@linux.ibm.com>
         <69ef3bb7-abdd-8c18-1afc-722d35a807c1@linux.ibm.com>
         <1578180770.5152.30.camel@linux.ibm.com>
         <748a5aaf-8537-4313-a020-18c57a6056bb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010615-0028-0000-0000-000003CEA8FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010615-0029-0000-0000-00002492B65B
Message-Id: <1578325821.5222.42.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_04:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060142
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 09:36 -0500, Ken Goldman wrote:
> On 1/4/2020 6:32 PM, Mimi Zohar wrote:
> > The "sig" and "modsig" hash algorithms are independent
> > of each other.  They might or might not be the same.
> 
> My question was about the d-modsig hash algorithm. Should the spec say:
> 
> 1 - If d-ng and d-modsig are both present, the hash algorithms MUST be 
> the same.

No, the hash algorithm does not need to be the same.  The "d-ng" hash
algorithm is based on the "sig" field, if present, and defaults to the
IMA default algorithm as specified in the Kconfig -
CONFIG_IMA_DEFAULT_HASH.  The appended signature ("sig" field), like
in the case of the kexec kernel image, might be a third party
signature.

> 
> I did have a question about the 'd-ng | sig | sig' template.  Is that an 
> error or could a file be signed with e.g. both RSA-2048 and RSA-3072?
> 
> Etc.  You can see where I'm going - precise rules for an IMA log verifier.

The "sig" field is the original IMA signature, stored as an extended
attribute.  If/when IMA fs-verity support is added, that signature
would require defining new digest and signature field types.  A
template with two "sig" fields doesn't make sense.

Mimi

