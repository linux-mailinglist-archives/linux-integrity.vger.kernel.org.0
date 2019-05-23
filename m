Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7663280B7
	for <lists+linux-integrity@lfdr.de>; Thu, 23 May 2019 17:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfEWPNO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 May 2019 11:13:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730709AbfEWPNO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 May 2019 11:13:14 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NF7hPm096479
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 11:13:13 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2snw3yk0w4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 23 May 2019 11:13:12 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 23 May 2019 16:13:11 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 May 2019 16:13:09 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4NFD8MK16973894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 May 2019 15:13:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2664C046;
        Thu, 23 May 2019 15:13:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E7564C040;
        Thu, 23 May 2019 15:13:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 May 2019 15:13:07 +0000 (GMT)
Subject: Re: [PATCH 1/4] ima-evm-utils: link to libcrypto instead of OpenSSL
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 23 May 2019 11:12:56 -0400
In-Reply-To: <20190523122623.25684-1-dbaryshkov@gmail.com>
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052315-0020-0000-0000-0000033FB881
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052315-0021-0000-0000-00002192A3A2
Message-Id: <1558624376.4347.167.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=793 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230103
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-05-23 at 15:26 +0300, Dmitry Eremin-Solenikov wrote:
> There is no need to link to full libssl. evmctl uses functions from
> libcrypto, so let's link only against that library.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Thank you for this patch and the other three.  They're all now in the
next branch.

Mimi

