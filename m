Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7911191BAA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2020 22:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCXVFt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Mar 2020 17:05:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727160AbgCXVFt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Mar 2020 17:05:49 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02OL30Bv094968
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2020 17:05:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywejwtwkv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2020 17:05:48 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 24 Mar 2020 21:05:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 24 Mar 2020 21:05:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02OL5gPV49938460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 21:05:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E99111C054;
        Tue, 24 Mar 2020 21:05:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EEFA11C052;
        Tue, 24 Mar 2020 21:05:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 21:05:41 +0000 (GMT)
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>
Date:   Tue, 24 Mar 2020 17:05:40 -0400
In-Reply-To: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
References: <85a96cad-dc04-a617-abfa-fb9427412e52@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20032421-0016-0000-0000-000002F716B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032421-0017-0000-0000-0000335AB670
Message-Id: <1585083940.5188.304.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_07:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 suspectscore=18 spamscore=0 mlxscore=0 mlxlogscore=978 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240105
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mikhail,

On Wed, 2019-12-04 at 01:41 +0300, Mikhail Novosyolov wrote:
> P.S. Patch is against commit 3eab1f93 "ima-evm-utils: Release
> version 1.2.1", I did not find newer git.

This patch doesn't apply to my current working branch or to that tag.

Mimi

