Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0285188912
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2020 16:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCQPWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Mar 2020 11:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726680AbgCQPWP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Mar 2020 11:22:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HFLfWL098474
        for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2020 11:22:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yrsdsesye-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Mar 2020 11:22:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <sachinp@linux.vnet.ibm.com>;
        Tue, 17 Mar 2020 15:22:11 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Mar 2020 15:22:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02HFM6cq58523826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 15:22:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 924EEAE064;
        Tue, 17 Mar 2020 15:22:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D933EAE051;
        Tue, 17 Mar 2020 15:22:04 +0000 (GMT)
Received: from [9.199.40.234] (unknown [9.199.40.234])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Mar 2020 15:22:04 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] tpm2: Export tpm2_get_cc_attrs_tbl for ibmvtpm driver as
 module
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
In-Reply-To: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
Date:   Tue, 17 Mar 2020 20:52:03 +0530
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Stefan Berger <stefanb@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20200317130819.720318-1-stefanb@linux.vnet.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-TM-AS-GCONF: 00
x-cbid: 20031715-4275-0000-0000-000003ADDF12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031715-4276-0000-0000-000038C30858
Message-Id: <03C24A2B-643D-4CDB-99FA-F5321684EEE4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_05:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170062
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On 17-Mar-2020, at 6:38 PM, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> 
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch fixes the following problem when the ibmvtpm driver
> is built as a module:
> 
> ERROR: modpost: "tpm2_get_cc_attrs_tbl" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:94: __modpost] Error 1
> make: *** [Makefile:1298: modules] Error 2
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>

Thanks
-Sachin

