Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A207D4448
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Oct 2023 02:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjJXAs0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Oct 2023 20:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjJXAsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2023 20:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5E9B
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2023 17:48:23 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O0k00b026835;
        Tue, 24 Oct 2023 00:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=CtxKdrav9/RhG5K3rqwsH9fxt6ug/syJbeMVEM2jcPo=;
 b=M2UOf9Hc/LBPyFmdPL55k96qU3yKJ6UOdcFbThoJL1L5PrEeWJRppcdb1tdHvo0GOSkl
 N14oI4pQt+t4AVcAKCHyocGk024qj7Afc//Ow1WucpHfI+WsKsMOZMofZqEPvX/hzwos
 4aQeny3IZ+nFxbshuVwVqj8jzilFAqnV8vwXjsItZj95wiNMS9fMORP7XWGli2+sL6e/
 golco7JA/4c6BBT3czniYTqCfYH6HC7vPaAk2u0IMKD2VsBCTbY75yY5QWVpPiQEMVl2
 2cD4+B26VyConn6LkBAM3pN8NLmghKmNA2/utGR0DwJyiDIsOk1tndlPjS1kZ09SUvVM Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tx3avgq4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 00:48:21 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39O0l1aX002233;
        Tue, 24 Oct 2023 00:48:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tx3avgq43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 00:48:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39NLXVDd010250;
        Tue, 24 Oct 2023 00:48:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbyc7u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 00:48:19 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39O0mJrh45154696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 00:48:19 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7496558058;
        Tue, 24 Oct 2023 00:48:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4FAA58059;
        Tue, 24 Oct 2023 00:48:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.48.240])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Oct 2023 00:48:18 +0000 (GMT)
Message-ID: <5ad2941ce2cc1895a38067f8f646e6080aea0219.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: fix indentation of config attributes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prasad Pandit <ppandit@redhat.com>
Cc:     linux-integrity@vger.kernel.org,
        Prasad Pandit <pjp@fedoraproject.org>
Date:   Mon, 23 Oct 2023 20:48:18 -0400
In-Reply-To: <20231022064723.167042-1-ppandit@redhat.com>
References: <20231022064723.167042-1-ppandit@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rWAMXbhZLlpueZEjERlju6-CyNYMvl7K
X-Proofpoint-ORIG-GUID: _Z92lRsnglAziyGbe4OARSEu1U-xrNV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_23,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=816 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240005
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2023-10-22 at 12:17 +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Fix indentation of config attributes. Attributes are generally
> indented with a leading tab(\t) character.
> 
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Thanks, applied.   

Mimi

