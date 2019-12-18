Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE51250DE
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 19:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRSnq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 13:43:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbfLRSnq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 13:43:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIIh8mB110056
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 13:43:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wykb76kgf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 13:43:45 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Dec 2019 18:43:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 18:43:39 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIIhcxr51314822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 18:43:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84CA84C04E;
        Wed, 18 Dec 2019 18:43:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10E5E4C044;
        Wed, 18 Dec 2019 18:43:37 +0000 (GMT)
Received: from dhcp-9-31-103-79.watson.ibm.com (unknown [9.31.103.79])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 18:43:36 +0000 (GMT)
Subject: Re: [PATCH] integrity: Expose data structures required for
 include/linux/integrity.h
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florent Revest <revest@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org, Matthew Garrett <mjg59@google.com>
Cc:     jmorris@namei.org, serge@hallyn.com, revest@google.com,
        allison@lohutok.net, armijn@tjaldur.nl, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kpsingh@chromium.org
Date:   Wed, 18 Dec 2019 13:43:36 -0500
In-Reply-To: <63f057fb98351324c8fc6210c42f3cbd76e85a68.camel@chromium.org>
References: <20191217134748.198011-1-revest@chromium.org>
         <e9e366d3-6c5d-743b-ffde-6b95b85884a2@schaufler-ca.com>
         <1576624105.4579.379.camel@linux.ibm.com>
         <2ae5127d76cbf78140fb2d6108c9ec70c7d8ae5d.camel@chromium.org>
         <1576676087.4579.396.camel@linux.ibm.com>
         <1576679307.4579.401.camel@linux.ibm.com>
         <63f057fb98351324c8fc6210c42f3cbd76e85a68.camel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121818-0016-0000-0000-000002D64333
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121818-0017-0000-0000-00003338833F
Message-Id: <1576694616.4579.412.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_06:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=3
 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-18 at 17:56 +0100, Florent Revest wrote:
> On Wed, 2019-12-18 at 09:28 -0500, Mimi Zohar wrote:
> > [Cc'ing Matthew]
> > 

> > > There's a major difference between returning just the file hash and
> > > making the integrity_iint_cache structure public. 
> 
> Certainly!
> I am new to this subsystem so I just wanted to get the discussion
> started. I am happy to make a more specific function.
> 
> > > Peter Moody's original code queried the cache[1].  Why do you need
> > > access to the structure itself?
> > > FYI, if/when we get to IMA namespacing, the cache structure will
> > > change.
> > > 
> > > [1] ima: add the ability to query ima for the hash of a given file.
> > 
> > If you're using Peter's patch, or something similar, I'd appreciate
> > your taking the time to upstream it.
> 
> Thank you for pointing me to Peter's patch! No one in my team was aware
> of his work on this. Ugh!
> It appears that Peter left the company while trying to upstream his
> patch and the situation just got stuck there for 4+ years now.
> 
> If you are still positive about the idea of a ima_file_hash function, I
> will take his v6 patch (this is the latest I could find on the
> sourceforce archives of linux-ima-devel), rebase it, take your comments
> into account and send a new version by the end of the week.

Matthew also wasn't aware of Peter's patch, until I sent it to him.  I
assume they're using it or something similar.  Please coordinate with
him, before refreshing and posting the patch.

thanks,

Mimi

