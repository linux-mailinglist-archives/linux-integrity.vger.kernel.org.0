Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10004C3F6
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2019 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSXKx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 19:10:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50922 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfFSXKx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 19:10:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JN7bKE140202
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 19:10:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7ty7fu73-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 19:10:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 20 Jun 2019 00:10:49 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 00:10:47 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JNAkxP36176132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 23:10:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9773E52054;
        Wed, 19 Jun 2019 23:10:46 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A8BFC52052;
        Wed, 19 Jun 2019 23:10:45 +0000 (GMT)
Subject: Re: [PATCH V5] IMA: support for per policy rule template formats
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 19 Jun 2019 19:10:45 -0400
In-Reply-To: <20190619224611.188276-1-matthewgarrett@google.com>
References: <20190619224611.188276-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061923-0016-0000-0000-0000028AA695
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061923-0017-0000-0000-000032E7FFAD
Message-Id: <1560985845.4025.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190189
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-06-19 at 15:46 -0700, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Inspired-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> 
> Reformatted to reduce indentation.

Thanks!  Push new version to #next-queued-testing.

Mimi

