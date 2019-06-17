Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66EC486B0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfFQPK7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 11:10:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727710AbfFQPK6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 11:10:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HF8exH108726
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 11:10:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t6bmh4wyc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 11:10:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 16:10:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 16:10:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HFAn6W62586936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 15:10:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E3FF4C044;
        Mon, 17 Jun 2019 15:10:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E5F34C052;
        Mon, 17 Jun 2019 15:10:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 15:10:48 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] ima-evm-utils: Convert sign v2 from RSA to
 EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:10:37 -0400
In-Reply-To: <20190617144232.qp2gnjrowgu7soot@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
         <20190614015410.26039-5-vt@altlinux.org>
         <1560778486.4072.80.camel@linux.ibm.com>
         <20190617144232.qp2gnjrowgu7soot@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061715-0016-0000-0000-00000289D7BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061715-0017-0000-0000-000032E72224
Message-Id: <1560784237.4072.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-17 at 17:42 +0300, Vitaly Chikunov wrote:

> > I like simple stories, where everything is laid out.  Think of a patch
> > set as a simple story, not a mystery, explaining how you go from point
> > A to point B.  Each patch in the series explains the next step.
> > 
> > The changes in cmd_import() are nice, straight forward, and easy to
> > read.  Other than the "calc_keyid_v2()" change from passing an RSA key
> > to pkey key" dependency, this could be a separate patch.
> > Please see if you could further break this patch up to simplify review.
> 
> I thought about splitting as much as possible, but didn't not find what
> to split more.
> 
> - If we add read_pub_pkey into cmd_import then we can not use old
> calc_keyid_v2 (which wants RSA).
> - If we add new calc_keyid_v2 into cmd_import it would require calling
> read_pub_pkey (and have sign_hash_v2 updated too).
> - We can not put cmd_import change before 'rsa to pkey' change, because
> calc_keyid_v2 is also used in new sign_hash_v2.
> - We can not put cmd_import change after 'rsa to pkey' change, because
> cmd_import will fail for v2 signatures (which should use PKEY).
> 
> So I don't see how this is splittable.

Perhaps it causes more patch churn, but there always is a way.  In
this case, there are a couple of ways.  Instead of replacing "key"
with "pkey":

- define pkey as an additional argument to calc_keyid_v2().
- define a new function named, for example, calc_keyid_v2_pkey().

Mimi

