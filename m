Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF43893E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2019 13:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFGLm0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jun 2019 07:42:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727553AbfFGLm0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jun 2019 07:42:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x57BgHri135713
        for <linux-integrity@vger.kernel.org>; Fri, 7 Jun 2019 07:42:25 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2syn0weea8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 07 Jun 2019 07:42:24 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 7 Jun 2019 12:42:22 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 12:42:19 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x57BgIhu34013422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 11:42:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D674811C04C;
        Fri,  7 Jun 2019 11:42:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CCB011C052;
        Fri,  7 Jun 2019 11:42:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.48])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 11:42:17 +0000 (GMT)
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        prakhar srivastava <prsriva02@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date:   Fri, 07 Jun 2019 07:42:07 -0400
In-Reply-To: <b2e6f9c5-792c-8205-956d-468d059ea296@huawei.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
         <1559691534.4278.14.camel@linux.ibm.com>
         <CACdnJuvva4n5dDfoUhzZ9RAxzR=Wou4SuLfe8DCGp4f53cXM3w@mail.gmail.com>
         <1559761830.4278.30.camel@linux.ibm.com>
         <40275b34-c86e-7550-9eec-78a2b1d316f7@huawei.com>
         <1559861118.4278.182.camel@linux.ibm.com>
         <b2e6f9c5-792c-8205-956d-468d059ea296@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060711-0020-0000-0000-000003480B13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060711-0021-0000-0000-0000219B2473
Message-Id: <1559907727.4278.222.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-07 at 08:46 +0200, Roberto Sassu wrote:
> On 6/7/2019 12:45 AM, Mimi Zohar wrote:
> > On Thu, 2019-06-06 at 10:09 +0200, Roberto Sassu wrote:
> >> On 6/5/2019 9:10 PM, Mimi Zohar wrote:
> >>> On Wed, 2019-06-05 at 11:12 -0700, Matthew Garrett wrote:
> >>>> On Tue, Jun 4, 2019 at 4:39 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >>>>> Matthew, what is a "profile"?  Could we rename this patch to something
> >>>>> clearer?  Maybe something like "support for per policy rule template
> >>>>> formats"?
> >>>>
> >>>> Sounds good to me. Could you also add an Inspired-By: Roberto Sassu
> >>>> <roberto.sassu@huawei.com> ?
> >>>
> >>> Thanks, done.
> >>
> >> Thanks Matthew.
> >>
> >> If the patch it is not merged yet, please define and initialize the
> >> template_name variable in ima_policy_show() as the same as in
> >> ima_measurement_show().
> > 
> > The policy rule processing should prevent loading a custom policy with
> > a template rule, without specifying a valid template name.  Why does
> > ima_policy_show() need to initialize entry->template->name?
> 
> The last element of builtin_templates is reserved for a custom format
> that can be specified with the ima_template_fmt= kernel option. This
> last element has name length equal to zero. It can be found by
> lookup_template_desc() if specified in a policy rule.

Right, so that would be added with the per policy rule template fields
support.

Mimi

