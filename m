Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBB257019F
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Jul 2022 14:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGKMEX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Jul 2022 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiGKMEV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Jul 2022 08:04:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66741D33;
        Mon, 11 Jul 2022 05:04:20 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BBJPKt014047;
        Mon, 11 Jul 2022 12:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dy5qnrY8PKyQYQC1yezcdT8KNhS4VxqtVLh8J5ex2n0=;
 b=kldtlybrL5SobUYT5Gx/8XXk5K2c3LFBfbnr25NJqOxoa2Ve+4PeBkpMFOGvYfaifTwR
 xdfVysUDoMrcEasglFMFDRXwyLEHnJuzLJBf388+HcEsUoDCek+GX2Qm2GEXtdqFq/e9
 iE1VOH0aXbuxFl1Vj+xHxHIyblZ0GEkj6Ej3XBgOwuFdLXwC4Xz7XDracfuHZC8zDNCz
 l1T4Ac+pc45iuUmsqZLfCtKFvKMxhlnY/fw4VVcN4rR8nGYHvxmCnhgoqi7fxnre+CKi
 5vglCmgwIFBoxXTcq89TUDgVJgP62QFUw6s6CQSxSef9RBJciPDhDsWf1EuL6zQ1fNJv mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84sagfn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 12:04:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26BAXTw3026877;
        Mon, 11 Jul 2022 12:04:10 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h84sagfkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 12:04:09 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26BBq16i027196;
        Mon, 11 Jul 2022 12:04:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8tpgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 12:04:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26BC45nA17629598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 12:04:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 113D9A4060;
        Mon, 11 Jul 2022 12:04:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04CFBA405F;
        Mon, 11 Jul 2022 12:04:03 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.107.19])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jul 2022 12:04:02 +0000 (GMT)
Message-ID: <81ea189fd671947efc61000a745599a4b0573370.camel@linux.ibm.com>
Subject: Re: [PATCH] ima/evm: Fix potential memory leak in ima_init_crypto()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jianglei Nie <niejianglei2021@163.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Jul 2022 08:04:01 -0400
In-Reply-To: <20220711072202.2319030-1-niejianglei2021@163.com>
References: <20220711072202.2319030-1-niejianglei2021@163.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kM73rs2Rr-dLTyIY3ri_t9sjkc7zXq29
X-Proofpoint-ORIG-GUID: ESBp5WcxjtrgDeLcV_KlZiXzMkb1K52C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_17,2022-07-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=797 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207110052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-07-11 at 15:22 +0800, Jianglei Nie wrote:
> This patch adds the missing kfree() for ima_algo_array allocated by
> kcalloc() to avoid potential memory leak.

Missing is the reason that ima_algo_array is being freed.

Perhaps something like, 
"On failure to allocate the SHA1 tfm, IMA fails to initialize and exits
without freeing the ima_algo_array.   Add the missing kfree() for
ima_algo_array to avoid the potential memory leak."

thanks,

Mimi

