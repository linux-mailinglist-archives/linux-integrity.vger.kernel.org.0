Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3782350C0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDUQ2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 16:16:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726354AbfFDUQ2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 16:16:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54KD59M073301
        for <linux-integrity@vger.kernel.org>; Tue, 4 Jun 2019 16:16:27 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swve1g3wt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 16:16:26 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 4 Jun 2019 21:16:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 21:16:23 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54KGMur52428956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 20:16:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 591CE4204F;
        Tue,  4 Jun 2019 20:16:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9151F42047;
        Tue,  4 Jun 2019 20:16:21 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 20:16:21 +0000 (GMT)
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 04 Jun 2019 16:16:21 -0400
In-Reply-To: <CACdnJuvYzGBsAvmcP_6u+Zvr+AKTrKweJDbjurtZ02-HBbJN1Q@mail.gmail.com>
References: <20190603201322.7443-1-matthewgarrett@google.com>
         <1559613113.3956.9.camel@linux.ibm.com>
         <CACdnJuvYzGBsAvmcP_6u+Zvr+AKTrKweJDbjurtZ02-HBbJN1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060420-0028-0000-0000-000003758631
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060420-0029-0000-0000-000024355FAA
Message-Id: <1559679381.4237.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040128
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-06-04 at 13:03 -0700, Matthew Garrett wrote:
> On Mon, Jun 3, 2019 at 6:52 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2019-06-03 at 13:13 -0700, Matthew Garrett wrote:
> > > +                     template:= name or format of a defined IMA template
> > > +                     type (eg,ima-ng or d-ng|n-ng). Only valid when action
> > > +                     is "measure".
> >
> > This patch only supports specifying the template name, not the
> > template format description.  Please remove "d-ng|n-ng".
> 
> It supports specifying the template format, as long as the template
> format is already defined. I can remove the example, but it'll still
> work.

Correct, as mentioned in subsequent posts.  Until full support for
template field descriptions is added, please remove the field format
example.

> 
> > >       struct ima_rule_entry *entry;
> > >       int action = 0, actmask = flags | (flags << 1);
> > > @@ -438,6 +441,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> > >               if ((pcr) && (entry->flags & IMA_PCR))
> > >                       *pcr = entry->pcr;
> > >
> > > +             if (template_desc && entry->template)
> > > +                     *template_desc = entry->template;
> > > +             else
> > > +                     *template_desc = ima_template_desc_current();
> > > +
> >
> > This code is finding the template format, but is subsequently being
> > replaced with the current description.  One way of fixing this, is by
> > initializing the template_desc before walking the list.
> 
> Ok

Subsequent posts pointed out that either all callers to
ima_match_policy() need to pass a pointer to template_desc or
*template_desc needs to be tested.

thanks!

Mimi
 

