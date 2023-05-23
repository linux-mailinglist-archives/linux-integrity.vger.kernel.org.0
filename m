Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3970E888
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238666AbjEWWBm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 18:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbjEWWBf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 18:01:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC537C5;
        Tue, 23 May 2023 15:01:32 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLeJkp015700;
        Tue, 23 May 2023 22:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/jjtrnH3eKCUnuPoOJ0mUy0xU82INiJEpztksDmwYy4=;
 b=ESTRgNgkDqtJFhw8OB3RjL/1A2e2zF3pbuwegvZFhFLSyNw5G6VW8ya5v/ZAyNb5NOrx
 78uYUnvuXJS3W9ns9x1mUh6RHDeRESgj91KpruRNilNjv/1kxTDTWITuyk0N1TwBHL/C
 lvaMUFelpvpJD1q2Ttmz2ccSW1jSUguDO0BWU8GfYGlCjjql1voG+QLph0redLEH5Jb5
 G2dCMO3E05byjKMGgHn2y/bIRpigElPjgTqjh0ZwZDo9JOiavv2jBAvjGmbQURcNvt+E
 ZReDbrAsXwwEVtxyzOPDYBmgTHEMz2aeUBSt0ItWQQn6fd5va8lOyEfDIFItYIi32jCz +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs58egpte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:05 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NLgs6o023317;
        Tue, 23 May 2023 22:01:05 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs58egps3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:04 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NKk1px030256;
        Tue, 23 May 2023 22:01:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qppcd5agm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 22:01:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34NM11jP37749060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 22:01:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 433FA58062;
        Tue, 23 May 2023 22:01:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F6E958064;
        Tue, 23 May 2023 22:00:59 +0000 (GMT)
Received: from wecm-9-67-154-32.wecm.ibm.com (unknown [9.67.154.32])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 23 May 2023 22:00:59 +0000 (GMT)
Message-ID: <4df74ef9afdf6ed5a1a65489d1136d825cb391e0.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] KEYS: DigitalSignature link restriction
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, jarkko@kernel.org,
        dhowells@redhat.com, dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, jlee@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 23 May 2023 18:00:59 -0400
In-Reply-To: <20230522230944.180389-2-eric.snowberg@oracle.com>
References: <20230522230944.180389-1-eric.snowberg@oracle.com>
         <20230522230944.180389-2-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Qa6LhjnwN6PmRIhPmFc0Wq1-AaW_QFk
X-Proofpoint-GUID: EEBRHBzQSbEAnG_qyrtjfhgzFvqLNgRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230173
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-05-22 at 19:09 -0400, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key having digitalSignature usage set. Additionally, verify
> the new certificate against the ones in the system keyrings.  Add two
> additional functions to use the new restriction within either the builtin
> or secondary keyrings.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Jarkko, please update the above tag to Reviewed-and-tested-by. 
-- 
thanks,

Mimi

