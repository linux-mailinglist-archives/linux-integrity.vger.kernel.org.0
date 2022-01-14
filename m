Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E048EAA0
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 14:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiANN1h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 08:27:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235222AbiANN1g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 08:27:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ECrVgS030473;
        Fri, 14 Jan 2022 13:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LQVK3PWHhEVZj9NJeLbJSmcD0L8Z5fH6JODv7w3uJwI=;
 b=JAoBvyn20lWQOjvnnRg3qA2YtDyZhE0z+fsQrSQbIcPS79ji7aN4uYEXBQLmdEwTH0rd
 a2YyHLnbTqFH1mAJE6lQk1+XKbPHETGJ6Ho9roKhltwoTwTze5zgvkx9G8ATevvayIYZ
 m4mX8UNUe/NYS5IEmHqkwDoaOKS8SE/4Ck+PHUeDVxbJFn55C8B4v6Rh1J4lVR7h1msG
 Q/HngpHyi5CdHOZ8ifH+HJT4QVBUGDWuJ47DO7uDM5JO1Bx0QGrtNw+zddCw6hxHQrEb
 11ICIpY1YVV6UXLgBzWuz1nhpkIEI+eTzekpWQQUyLXuny7bGpha9+Pk1xfvX6Er8TmF Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dk9k1gm9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:27:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20ECvcQs015418;
        Fri, 14 Jan 2022 13:27:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dk9k1gm8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:27:33 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20EDRWYP006415;
        Fri, 14 Jan 2022 13:27:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3df28abpsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 13:27:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20EDRTYr42926572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 13:27:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72D30A4051;
        Fri, 14 Jan 2022 13:27:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 391CDA4040;
        Fri, 14 Jan 2022 13:27:28 +0000 (GMT)
Received: from sig-9-65-86-203.ibm.com (unknown [9.65.86.203])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jan 2022 13:27:28 +0000 (GMT)
Message-ID: <dd5b09c0985f47fe164df06f8f2f387c0332c5ec.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Joe Perches <joe@perches.com>,
        Austin Kim <austinkernel.kim@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Cc:     dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jan 2022 08:27:27 -0500
In-Reply-To: <d9478a99032ea7182e0cd30ea822c1993ac2cd68.camel@perches.com>
References: <20211124214418.GA1094@raspberrypi>
         <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
         <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
         <d9478a99032ea7182e0cd30ea822c1993ac2cd68.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UPEh_h6DxCi7fnNqtYRyPhuDj3PnHpzp
X-Proofpoint-GUID: KNTF8P1ia6M_MZXHcG3vGqA1JLSlDxJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_04,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=984 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Joe,

On Thu, 2022-01-13 at 18:05 -0800, Joe Perches wrote:
> On Thu, 2022-01-13 at 20:51 -0500, Mimi Zohar wrote:
> > On Wed, 2022-01-12 at 17:46 +0900, Austin Kim wrote:
> > > > There are a few minor typos in the comments. Fix these.
> > It would be really nice if checkpatch.pl would catch spelling mistakes
> > before the patch was upstreamed.
> 
> Try ./scripts/checkpatch.pl --strict

"--strict" didn't find the typos in comments, but "--codespell" did. 
Nice!

thanks,

Mimi

