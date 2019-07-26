Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE8275C65
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 03:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGZBDM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 21:03:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbfGZBDM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 21:03:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6Q11kZx053378
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 21:03:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tymek5uwh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 25 Jul 2019 21:03:11 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 26 Jul 2019 02:03:10 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Jul 2019 02:03:06 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6Q136QG58589292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 01:03:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E57EE42049;
        Fri, 26 Jul 2019 01:03:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CD2C42045;
        Fri, 26 Jul 2019 01:03:05 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jul 2019 01:03:05 +0000 (GMT)
Subject: Re: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 25 Jul 2019 21:03:04 -0400
In-Reply-To: <20190725153823.dz6brcvoojum47dz@altlinux.org>
References: <20190725061855.3734-1-vt@altlinux.org>
         <1564065991.4245.132.camel@linux.ibm.com>
         <20190725153823.dz6brcvoojum47dz@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072601-4275-0000-0000-00000350B882
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072601-4276-0000-0000-00003860F6C1
Message-Id: <1564102984.4245.199.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-07-25 at 18:38 +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Thu, Jul 25, 2019 at 10:46:31AM -0400, Mimi Zohar wrote:
> > On Thu, 2019-07-25 at 09:18 +0300, Vitaly Chikunov wrote:
> > > Run `make check' to execute the tests.
> > > Currently only ima_hash, ima_sign (v2), and ima_verify are tested.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > 
> > Nice!  As much as I would like to include this patch in this release,
> > let's hold off and add it to the next release.
> 
> You may include it if you wish, this should work good as is (over my
> latest patches).

Yes, it applies cleanly on top of the other patches.
> 
> > Reviewing shorter patches is a lot easier, at least for me.  Could you
> > break this patch up?  Perhaps by defining the tests separately, and
> > then adding the autotools support to run the test afterwards?
> 
> This is just tests, so they don't alter any other code, don't produce
> user visible features, and don't complicate anything. Each file inside
> of the patch could be understood separately.

I understand that.  However, without comments, with short function
names, and single letter variable names, makes reviewing the code more
difficult than needed.

Mimi

