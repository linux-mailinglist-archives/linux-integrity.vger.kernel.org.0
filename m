Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A568409A1B
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbhIMQ4l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 12:56:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239478AbhIMQ4l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 12:56:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DGXKxq018622
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=OatwaV+fZud0o8Ze79ccdVH7wwII1GhR+Ygp/Ym5FoU=;
 b=ZgyqvuTVOPz7BBotrPZA+SQhufVSW8YpuDMSZT9R/O4rlLecgqa2QsH1OwcjeOmGTyIT
 umol0EYzNJaaj0V5U8S4tFyZd5g7IcKScxIFstconSjsK0DGBbLeP4Zx3oq22g3WroFK
 +iNr8Xvrc3MWeqBkV1v+rfeKdTkCBWvA3DRG+jmiGed/pU98Sb8YZpkgFNcDzXbYk9vF
 3coh+4L95vBKd1gZu13j+UbGxqxUGxpBrJ5O1iMvMcwpFxMKykLxhUOuJVqdTNf9ZTwM
 QKLCr2wrguVmEL01zmDr8ZCsxk67NS6m+3co1S7gwuXeJrmKdW6O7WB2VrxembF8Fril TA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b247731pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 12:55:24 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DGrKmv021349
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:55:22 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3b0m392wx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 16:55:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DGtJnm29819376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:55:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48A76A4053;
        Mon, 13 Sep 2021 16:55:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3E2FA405E;
        Mon, 13 Sep 2021 16:55:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 16:55:18 +0000 (GMT)
Message-ID: <491cd499861f8a7cd22dd869ffb80774973cc8a4.camel@linux.ibm.com>
Subject: Re: [PATCH v3 9/9] tests: Get the packages for pkcs11 testing on
 the CI/CD system
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Date:   Mon, 13 Sep 2021 12:55:18 -0400
In-Reply-To: <20210908192343.4147739-10-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
         <20210908192343.4147739-10-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qLACAuNadCo62NGBXGt6JTr7j5E8HZHX
X-Proofpoint-ORIG-GUID: qLACAuNadCo62NGBXGt6JTr7j5E8HZHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130063
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-09-08 at 15:23 -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Get the packages for pkcs11 testing on the CI/CD system.

How about saying, "Get the packages for pkcs11 testing on the CI/CD
system, where available.  On those system where it is not available,
skip the two tests."

Then just list those that do not have pkcs11 support or it's too old.

thanks,

Mimi

> 
> This is the status on various distros:
> 
> - Alpine: could not find package with pkcs11 engine
> - Alt Linux: works
> - Debian: works
> - CentOS7: softhsm 2.1.0 is too old for tests to work; tests also fail
>            when trying to sign with pkcs11 URI using openssl command line tool
> - CentOS: works
> - Fedora: works
> - OpenSuSE Leap: package not available in main repo
> - OpenSuSE Tumbleweed: works
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

