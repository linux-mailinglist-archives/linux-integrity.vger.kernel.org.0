Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8527E615
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfHAW5T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 18:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731204AbfHAW5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 18:57:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71Mv4ZI053087
        for <linux-integrity@vger.kernel.org>; Thu, 1 Aug 2019 18:57:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u48mgs757-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 18:57:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 1 Aug 2019 23:57:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:57:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MvBEJ55902348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:57:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8550AE051;
        Thu,  1 Aug 2019 22:57:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC172AE04D;
        Thu,  1 Aug 2019 22:57:09 +0000 (GMT)
Received: from dhcp-9-31-103-47.watson.ibm.com (unknown [9.31.103.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:57:09 +0000 (GMT)
Subject: Re: [PATCH] ima: Allow to import the blacklisted cert signed by
 secondary CA cert
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, dhowells@redhat.com,
        dmitry.kasatkin@gmail.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mark D. Baushke" <mdb@juniper.net>,
        Petko Manolov <petkan@mip-labs.com>
Date:   Thu, 01 Aug 2019 18:57:09 -0400
In-Reply-To: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1564622625-112173-1-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080122-0012-0000-0000-00000338828B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0013-0000-0000-000021723110
Message-Id: <1564700229.11223.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010242
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jia,

On Thu, 2019-08-01 at 09:23 +0800, Jia Zhang wrote:
> Similar to .ima, the cert imported to .ima_blacklist is able to be
> authenticated by a secondary CA cert.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

The IMA blacklist, which is defined as experimental for a reason, was
upstreamed prior to the system blacklist.  Any reason you're not using
the system blacklist?  Before making this sort of change, I'd like
some input from others.

thanks,

Mimi

