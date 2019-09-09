Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89CDAD705
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 12:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfIIKkL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 06:40:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbfIIKkL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 06:40:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x89Adc05122591
        for <linux-integrity@vger.kernel.org>; Mon, 9 Sep 2019 06:40:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uwm9fjpcr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Sep 2019 06:40:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 9 Sep 2019 11:40:07 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Sep 2019 11:40:04 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x89Ae3Ic27263124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Sep 2019 10:40:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF6F911C05B;
        Mon,  9 Sep 2019 10:40:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B34111C04C;
        Mon,  9 Sep 2019 10:40:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.159.93])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Sep 2019 10:40:02 +0000 (GMT)
Subject: Re: KEYS-TRUSTED git
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        dhowells@redhat.com, Kenneth Goldman <kgoldman@us.ibm.com>,
        David Safford <david.safford@ge.com>,
        Monty Wiseman <monty.wiseman@ge.com>
Date:   Mon, 09 Sep 2019 06:40:01 -0400
In-Reply-To: <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
References: <c253ca7292b397f1352d2ee00fce0b011f84abff.camel@linux.intel.com>
         <1567952431.4614.140.camel@linux.ibm.com>
         <CAFA6WYPq8Tq6=jTqnWQf9w9pzdJu8AcX-CFBWPwoVmMaLEJKhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090910-0016-0000-0000-000002A8B94F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090910-0017-0000-0000-000033093A22
Message-Id: <1568025601.4614.253.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Ken, Dave, & Monty]

On Mon, 2019-09-09 at 11:57 +0530, Sumit Garg wrote:
> On Sun, 8 Sep 2019 at 19:50, Mimi Zohar <zohar@linux.ibm.com> wrote:

> > Are all "trust" methods equivalent?  As new "trust" methods are
> > defined, there should be a document describing the trust method, with
> > a comparison to the TPM.
> 
> For Trusted Execution Environment (TEE) as a new "trust" method, I
> have tried to document it here [1]. Please share your thoughts on this
> patch [1] in case I missed something. I would be happy to incorporate
> your feedback. Also, can you elaborate on "comparison to the TPM",
> what specifics parameters are you looking for documentation?

For example, the security properties/guarantees of a hardware TPM are
different than a software TPM.  Could we capture that difference in
chart form?  As new "trust" methods are added, include that
information in the chart and extend the chart with other information,
as needed.

Mimi

> 
> [1] https://patchwork.kernel.org/patch/11065679/
> 
> -Sumit

