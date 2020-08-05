Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51FA23D1FF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHEUIP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 16:08:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgHEQcf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:35 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075DWRZ0022537;
        Wed, 5 Aug 2020 09:32:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32qssaq8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:31:47 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075D39CE112371;
        Wed, 5 Aug 2020 09:31:47 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32qssaq8sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:31:47 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075DPTuC002521;
        Wed, 5 Aug 2020 13:31:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 32n017tpqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 13:31:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075DVh0w17760738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 13:31:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13942A4060;
        Wed,  5 Aug 2020 13:31:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B70A8A4054;
        Wed,  5 Aug 2020 13:31:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 13:31:41 +0000 (GMT)
Message-ID: <e01f39f3e0abc9f799bbe0a50e803287b9458888.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Wed, 05 Aug 2020 09:31:40 -0400
In-Reply-To: <20200805094215.GA32709@dell5510>
References: <20200731210653.p5m4efy52melqwgs@altlinux.org>
         <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
         <1157c464d49cb6297fc2f20771d73a4cf7ce6599.camel@linux.ibm.com>
         <20200803130755.GA30440@dell5510>
         <22a744e9520237907312d1f71293df0dd809805f.camel@linux.ibm.com>
         <20200803164635.GB4914@dell5510>
         <bc771e16d4afd3454dea37537f759343452c6446.camel@linux.ibm.com>
         <20200804072234.GA4337@dell5510> <20200804075453.GA7285@dell5510>
         <980a1c491dcc03606635cdddce8b19e7a2e041c5.camel@linux.ibm.com>
         <20200805094215.GA32709@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_09:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-05 at 11:42 +0200, Petr Vorel wrote:
> Hi Mimi, Vitaly,
> 
> ...
> > "[PATCH v3 1/1] tpm: add sysfs exports for all banks of PCR registers"
> > was posted here on the linux-integrity mailing list[1].  It's important
> > to get this patch upstreamed, but I think the PCR file format is useful
> > on its own.  For this reason, I'm going to backtrack and include it in
> > 1.3.1.
> Thanks a lot for info!
> 
> > I've posted a new version of "travis: openssl gost engine" addressing
> > the branch version and lack of an install target.   It assumes that
> > openssl was built with engine support and builds the gost engine
> > support from the git repo.  The environment variable is set, but has
> > not been tested.
> > Everything, including this change, should now be in the next-testing
> > branch.
> Nice, thanks! Tested:
> https://travis-ci.org/github/pevik/ima-evm-utils

From the log, I see I somehow re-introduced testing "${SSL}" =
"openssl".  I've removed it again and pushed out the update version.

> I hope I'll have time for docker based travis patch next week.

Thanks!

Mimi

