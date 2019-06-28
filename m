Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D7859955
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfF1LmB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 07:42:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726564AbfF1LmB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 07:42:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SBcIAx115003
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jun 2019 07:42:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdhnd9dhk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 28 Jun 2019 07:42:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 28 Jun 2019 12:41:57 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 12:41:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SBfroG58458292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 11:41:53 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 464294C044;
        Fri, 28 Jun 2019 11:41:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 660CD4C04E;
        Fri, 28 Jun 2019 11:41:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.81.240])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 11:41:52 +0000 (GMT)
Subject: Re: [PATCH] ima: Update MAX_TEMPLATE_NAME_LEN to fit largest
 reasonable definition
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 07:41:41 -0400
In-Reply-To: <20190627232546.28746-1-bauerman@linux.ibm.com>
References: <20190627232546.28746-1-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062811-0016-0000-0000-0000028D563F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062811-0017-0000-0000-000032EAD99E
Message-Id: <1561722101.4264.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-06-27 at 20:25 -0300, Thiago Jung Bauermann wrote:
> MAX_TEMPLATE_NAME_LEN is used when restoring measurements carried over from
> a kexec. It should be set to the length of a template containing all fields
> except for 'd' and 'n', which don't need to be accounted for since they
> shouldn't be defined in the same template description as 'd-ng' and 'n-ng'.
> 
> That length is greater than the current 15, so update using a sizeof() to
> show where the number comes from and also can be visually shown to be
> correct. The sizeof() is calculated at compile time.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Thanks, it's now in next-queued-testing.

Mimi

