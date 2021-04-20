Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004703661A4
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 23:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDTVdh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 17:33:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29508 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233724AbhDTVdg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 17:33:36 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KL3YH9056808;
        Tue, 20 Apr 2021 17:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=mt9sy6k0dtVEyWThU2tyxcLEqeiSQ9M65Pmrr4XgxOM=;
 b=CCJCw6ZvBV/YoNW6PpR9r4GIU6LpOJB+25LrXib10Mv84caSCDYXOR6C1khn0OfHygT1
 LBHAWk3LCP8AdiozQlFj3SY3y9fOcU9VgaHBDZh+IW14EQ94sBoeq5eXpc4Bn170NEBp
 F1uyVpF4xSsCyJGPXRot9nFjz5RzuIaNPpJtq1r9Qh5JI2DGTWR8PXKwJ1qLfEHnpkRi
 9r1d80jlQ+uB4suX/BTY1vYvOq/ei+uboOE0Dl0jtrP6IopM89O2kEvNeJ7Yq2ABYsOz
 Hz6bU9YL9xpCeB/F9orcTP791APVG3J5XC2renAtVMqOPV/5Ms/DlNB6OfiMBX3YwHOe 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3823qgn7wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 17:32:42 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KL3qMN058089;
        Tue, 20 Apr 2021 17:32:41 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3823qgn7w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 17:32:41 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KLSx42022245;
        Tue, 20 Apr 2021 21:32:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 37ypxh92nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 21:32:39 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KLWbdN27722158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 21:32:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C92AA404D;
        Tue, 20 Apr 2021 21:32:37 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A047CA4040;
        Tue, 20 Apr 2021 21:32:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.121.1])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 21:32:34 +0000 (GMT)
Message-ID: <079454b4147b6ca054129490cd256c948ea08cc1.camel@linux.ibm.com>
Subject: Re: [PATCH 010/141] ima: Fix fall-through warnings for Clang
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Tue, 20 Apr 2021 17:32:33 -0400
In-Reply-To: <77650781-7088-21b7-aa8e-8e5fbf81920e@embeddedor.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
         <ae416f97079da13568026228d930e9e59118cc4c.1605896059.git.gustavoars@kernel.org>
         <77650781-7088-21b7-aa8e-8e5fbf81920e@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AfdWPR04Znax-0yFUCd8E65glb8rgAtG
X-Proofpoint-GUID: H9__Ijr0eubhGQoZwle13wsIgSOTA68_
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_11:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200146
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Gustavo,

On Tue, 2021-04-20 at 15:28 -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: who can take this, please?

Thank you for the reminder.

> 
> On 11/20/20 12:25, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of just
> > letting the code fall through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git 
next-integrity

thanks,

Mimi

