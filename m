Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E661105B3
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2019 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLCUHF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Dec 2019 15:07:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbfLCUHF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Dec 2019 15:07:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3JbJCh035804
        for <linux-integrity@vger.kernel.org>; Tue, 3 Dec 2019 15:07:04 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnp8ryq35-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 03 Dec 2019 15:07:03 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 3 Dec 2019 20:07:02 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 20:06:59 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3K6HcB40567262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 20:06:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24DF1A4053;
        Tue,  3 Dec 2019 20:06:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161CFA4055;
        Tue,  3 Dec 2019 20:06:57 +0000 (GMT)
Received: from dhcp-9-31-103-87.watson.ibm.com (unknown [9.31.103.87])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 20:06:56 +0000 (GMT)
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Tue, 03 Dec 2019 15:06:56 -0500
In-Reply-To: <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>
         <20191127015654.3744-6-nramas@linux.microsoft.com>
         <1575375945.5241.16.camel@linux.ibm.com>
         <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19120320-4275-0000-0000-0000038AAE63
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120320-4276-0000-0000-0000389E4DE6
Message-Id: <1575403616.5241.76.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_06:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=871
 suspectscore=3 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030144
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-03 at 11:45 -0800, Lakshmi Ramasubramanian wrote:
> Hi Mimi,
> 
> On 12/3/2019 4:25 AM, Mimi Zohar wrote:
> 
> > 
> > A keyring can be created by any user with any keyring name, other than
> >   ones dot prefixed, which are limited to the trusted builtin keyrings.
> >   With a policy of "func=KEY_CHECK template=ima-buf keyrings=foo", for
> > example, keys loaded onto any keyring named "foo" will be measured.
> >   For files, the IMA policy may be constrained to a particular uid/gid.
> >   An additional method of identifying or constraining keyring names
> > needs to be defined.
> > 
> > Mimi
> > 
> 
> Are you expecting a functionality like the following?
> 
>   => Measure keys added to keyring "foo", but exclude certain keys 
> (based on some key identifier)
> 
> Sample policy might look like below:
> 
> action=MEASURE func=KEY_CHECK keyrings=foo|bar
> action=DONT_MEASURE key_magic=blah
> 
> So a key with key_magic "blah" will not be measured even though it is 
> added to the keyring "foo". But any other key added to "foo" will be 
> measured.
> 
> What would the constraining field in the key may be - Can it be SHA256 
> hash of the public key? Or, some other unique identifier?
> 
> Could you please clarify?

Suppose both root and uid 1000 define a keyring named "foo".  The
current "keyrings=foo" will measure all keys added to either keyring
named "foo".  There needs to be a way to limit measuring keys to a
particular keyring named "foo".

Mimi

