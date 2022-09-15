Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43D5B9A5A
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 14:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIOMHY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 08:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIOMHW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 08:07:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049377EB3
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 05:07:22 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB8Jv7015530;
        Thu, 15 Sep 2022 12:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=O0HKp463m+aZsZ99B83TcQ9Mv8y9/Es/1BsICCgwnFo=;
 b=tKlqOZ1nD3y/8kWHe+h1BwL5licThqBANH6FVSaoITouTZl0NxDHeoi34yOEbUZaqvNq
 tDUxFbgR1/M/9COKyrKZRQZ3MEV4aQFBsavFFPu29rDTtmW2rUgKKZLE7+hHbNxhbSk3
 GsXq5+Rz9JeNVUg8Bq9PEe4u5Uq+ADd4rLAE0xFLBbOSBBNQCYTflpGyWUCrwxTYK2Xt
 BTMi+SgzPSDHfMe/imHvP0NISXUr5JIraWBk7gU6ZxclT6SMJELsC4YTl8EE1zrlknEN
 nsVacUPceSRfRUNR9IwoNmdPhbHpzwYpXGAe9Sd1+4SoB1KKSjGXdHpHfvNPmr4cAoVe cw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm2wqhwf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 12:07:18 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FC6Pgo022882;
        Thu, 15 Sep 2022 12:07:16 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03wdc.us.ibm.com with ESMTP id 3jjy2eb4q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 12:07:16 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FC7FL514680358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 12:07:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B925DAE06F;
        Thu, 15 Sep 2022 12:07:15 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85B04AE06D;
        Thu, 15 Sep 2022 12:07:15 +0000 (GMT)
Received: from sig-9-77-142-138.ibm.com (unknown [9.77.142.138])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 12:07:15 +0000 (GMT)
Message-ID: <786161ba1d70c8120f1fd69e542fb6dcdceab5fe.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 1/4] Don't ignore number of items read
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>
Date:   Thu, 15 Sep 2022 08:07:15 -0400
In-Reply-To: <4da20657-7ee0-1cb0-72f7-53497b33cc34@linux.ibm.com>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
         <20220914142225.1381077-2-zohar@linux.ibm.com>
         <4da20657-7ee0-1cb0-72f7-53497b33cc34@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HT-gIR5uPnk6QDswbvQpLViq4HItB7_M
X-Proofpoint-ORIG-GUID: HT-gIR5uPnk6QDswbvQpLViq4HItB7_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for this and the other reviews.

On Wed, 2022-09-14 at 17:30 -0400, Stefan Berger wrote:
> 
> On 9/14/22 10:22, Mimi Zohar wrote:
> > fread() either returns the number of bytes read or the number of items
> > of data read.  Check that it returns the requested number of items read.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


> 
> It was correct before as well ...
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Yeah, I'll update the patch description explaining that this stops the
static analysis complaints

-- 
thanks,

Mimi

