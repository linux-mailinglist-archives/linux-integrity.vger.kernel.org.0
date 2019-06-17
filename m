Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA49F48420
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFQNfF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 09:35:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfFQNfF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 09:35:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HDW4bl093485
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:35:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t6bj891yj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 17 Jun 2019 09:35:03 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 17 Jun 2019 14:35:02 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 17 Jun 2019 14:34:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HDYw0j30540218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 13:34:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F071911C064;
        Mon, 17 Jun 2019 13:34:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD5A11C05B;
        Mon, 17 Jun 2019 13:34:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.90])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 13:34:57 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] ima-evm-utils: Convert sign v2 from RSA to
 EVP_PKEY API
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Mon, 17 Jun 2019 09:34:46 -0400
In-Reply-To: <20190614015410.26039-5-vt@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
         <20190614015410.26039-5-vt@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0028-0000-0000-0000037B0622
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0029-0000-0000-0000243B0A84
Message-Id: <1560778486.4072.80.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=961 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170125
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-06-14 at 04:54 +0300, Vitaly Chikunov wrote:
> Convert sign_v2 and related to using more generic EVP_PKEY API instead
> of RSA API. This enables more signatures to work out of the box.

Please elaborate on "enables more signatures to work out of the box",
perhaps with example(s).

I like simple stories, where everything is laid out.  Think of a patch
set as a simple story, not a mystery, explaining how you go from point
A to point B.  Each patch in the series explains the next step.

The changes in cmd_import() are nice, straight forward, and easy to
read.  Other than the "calc_keyid_v2()" change from passing an RSA key
to pkey key" dependency, this could be a separate patch.  Please see
if you could further break this patch up to simplify review.

Mimi

