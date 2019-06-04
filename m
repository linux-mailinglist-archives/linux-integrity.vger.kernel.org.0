Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92E535473
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 01:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfFDXjD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jun 2019 19:39:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfFDXjC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jun 2019 19:39:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54NaYb6118560
        for <linux-integrity@vger.kernel.org>; Tue, 4 Jun 2019 19:39:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sx0a1mary-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 04 Jun 2019 19:39:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 5 Jun 2019 00:38:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Jun 2019 00:38:56 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54NcttV53280968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 23:38:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58E044C04E;
        Tue,  4 Jun 2019 23:38:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8100A4C040;
        Tue,  4 Jun 2019 23:38:54 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 23:38:54 +0000 (GMT)
Subject: Re: [PATCH V4] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <mjg59@google.com>
Date:   Tue, 04 Jun 2019 19:38:54 -0400
In-Reply-To: <20190604203859.181156-1-matthewgarrett@google.com>
References: <20190604203859.181156-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060423-0016-0000-0000-000002847959
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060423-0017-0000-0000-000032E18BBE
Message-Id: <1559691534.4278.14.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040149
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matthew,

On Tue, 2019-06-04 at 13:38 -0700, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  Remove mention of template format from the documentation, and avoid
>  attempting to assign to template_desc if we weren't provided a pointer
>  in the first place.

Thanks!  I've pushed this patch out, for now, to the next-queued-
testing branch.  This will allow others to rebase their patch sets -
kexec command line measurement, the appended signatures, and the VFS
file hashes - on top of it.

Roberto, any chance you would be interested in adding the template
field format support?

Matthew, what is a "profile"?  Could we rename this patch to something
clearer?  Maybe something like "support for per policy rule template
formats"?

thanks!

Mimi

