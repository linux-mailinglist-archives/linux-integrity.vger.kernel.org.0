Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB481B11
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Aug 2019 15:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfHENLi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Aug 2019 09:11:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729385AbfHENLh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Aug 2019 09:11:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75D4XBq028690
        for <linux-integrity@vger.kernel.org>; Mon, 5 Aug 2019 09:11:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u6kykbgpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Aug 2019 09:11:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <prudo@linux.ibm.com>;
        Mon, 5 Aug 2019 14:11:32 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 5 Aug 2019 14:11:27 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x75DBPAY52166750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 13:11:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 270E742057;
        Mon,  5 Aug 2019 13:11:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9623542049;
        Mon,  5 Aug 2019 13:11:24 +0000 (GMT)
Received: from laptop-ibm (unknown [9.152.212.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 13:11:24 +0000 (GMT)
Date:   Mon, 5 Aug 2019 15:11:23 +0200
From:   Philipp Rudo <prudo@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "David Howells" <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v12 01/11] MODSIGN: Export module signature definitions
In-Reply-To: <8736iw9y00.fsf@morokweng.localdomain>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
        <20190628021934.4260-2-bauerman@linux.ibm.com>
        <20190701144752.GC25484@linux-8ccs>
        <87lfxel2q6.fsf@morokweng.localdomain>
        <20190704125427.31146026@laptop-ibm>
        <874l41ocf5.fsf@morokweng.localdomain>
        <20190705150000.372345b0@laptop-ibm>
        <8736iw9y00.fsf@morokweng.localdomain>
Organization: IBM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19080513-4275-0000-0000-000003549A8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080513-4276-0000-0000-0000386593D2
Message-Id: <20190805151123.12510d72@laptop-ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Thiago,

> > The patch looks good now.  
> 
> Thanks! Can I add your Reviewed-by?

sorry, for the late answer, but I was on vacation the last two weeks. I hope
it's not too late now.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>

