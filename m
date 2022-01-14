Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9848E247
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 02:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiANBvz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 20:51:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229808AbiANBvz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 20:51:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20E0rxDv028830;
        Fri, 14 Jan 2022 01:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=FWqdwM4ANrAQmVf923I5W/+WqJ53KsgOqmwpqxr2XJU=;
 b=YtX9fKPyG6XC0yrtEuI/xy9vfzjGIjhgGgkLIe6TJ+J9pgt5fM3Bg2HBKW7zRWlhTGiJ
 9k7MqtErn/31SDo5U2VAWUwiT/IFEZuwX1x9QDN01WfiEi+6r52Llri7QaKMSilR/sNF
 sPGcDM/n3X3wWYV2dOhWJlio8gA5FpBnbVUqGHefjxvzvZt9cPn4fIbedmDYObjnE60K
 UQ+dfgGRrdj0zqUUBq3TWyr793dsS9vYLSZAFvLrWUGoyaVMjoLnBsQ7L3gnr9JLN5tD
 l18YRtjZpXnpnk9BKbM7d+Y5HGhvrBu7cQVPw0YefOubckQJU1ZCh6aMnVaw3kFmeVJL SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djxngh97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:51:54 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20E1Q20D024523;
        Fri, 14 Jan 2022 01:51:53 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djxngh97f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:51:53 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20E1lvQ4017406;
        Fri, 14 Jan 2022 01:51:52 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3df1vk7tny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 01:51:51 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20E1pnu641288074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 01:51:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD3BFA4051;
        Fri, 14 Jan 2022 01:51:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72B72A4040;
        Fri, 14 Jan 2022 01:51:48 +0000 (GMT)
Received: from sig-9-65-76-253.ibm.com (unknown [9.65.76.253])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jan 2022 01:51:48 +0000 (GMT)
Message-ID: <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Austin Kim <austinkernel.kim@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Cc:     dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jan 2022 20:51:47 -0500
In-Reply-To: <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
References: <20211124214418.GA1094@raspberrypi>
         <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -GWrXPPYXWqLixqHaMvGKwKj86QhI_m6
X-Proofpoint-ORIG-GUID: 2avwOAaKqzibpaRZZqlFo6zXu5jJZqjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201140007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Austin,

On Wed, 2022-01-12 at 17:46 +0900, Austin Kim wrote:

> >
> > There are a few minor typos in the comments. Fix these.
> >
> > Signed-off-by: Austin Kim <austindh.kim@gmail.com>

It would be really nice if checkpatch.pl would catch spelling mistakes
before the patch was upstreamed.

thanks,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

