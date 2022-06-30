Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA091561B3A
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jun 2022 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiF3NY2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiF3NY1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 09:24:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EACB31506;
        Thu, 30 Jun 2022 06:24:26 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UDMs4O022552;
        Thu, 30 Jun 2022 13:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Z+ro5Et7tBZZj6wp64vUOY/VGo6qIkScJyzywET1CN0=;
 b=Y82ibb/Xg+qvULxXPg4KM+L5qRnI1bCOenkJJlH3LkZHlO8UiUeaKcMUkvDAwqwfXA5J
 VI0J49qlkwDWUzmc8jKdFlY30D6blkFlyJfN4pC/zohsDcgdV4sZyxM1MG7u0643RWn4
 YBnkCWzBMuUW+wPWTb0rFxVyUIF23S5bDNedB+PCfm/jAEmkn82pvjbtnhtrrCkug9ah
 JyiclMmTsIZFDsj/UPbMlHDxD5k5cLhyWsigArZSf9sL8AoQwe/BWiqZPZlAWoV3eO6D
 UPi+VBxCh5NDFG6GfylwrrLpXa/chq+/9Qu84AD+++VQNpIlV3Bm5BtxnV3MGvTfL5J7 dg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1cnhr0uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:24:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25UDLbeP014623;
        Thu, 30 Jun 2022 13:24:24 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj86ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 13:24:23 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25UDOKT422741380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 13:24:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1348A4051;
        Thu, 30 Jun 2022 13:24:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C257AA4040;
        Thu, 30 Jun 2022 13:24:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.82.30])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jun 2022 13:24:19 +0000 (GMT)
Message-ID: <6433f3d4c142ed9a7acddaad6e25829efc24e2d2.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Defer query for iversion until it is needed
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 30 Jun 2022 09:24:18 -0400
In-Reply-To: <20220630020346.1151942-1-stefanb@linux.ibm.com>
References: <20220630020346.1151942-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: proXjy4CjmId8f4g4Hpc9w6OsT52FQjm
X-Proofpoint-ORIG-GUID: proXjy4CjmId8f4g4Hpc9w6OsT52FQjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Wed, 2022-06-29 at 22:03 -0400, Stefan Berger wrote:
> Defer the query for the iversion until it is needed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  security/integrity/ima/ima_api.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index c1e76282b5ee..4410d45eb281 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -248,7 +248,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  	int result = 0;
>  	int length;
>  	void *tmpbuf;
> -	u64 i_version;
>  
>  	/*
>  	 * Always collect the modsig, because IMA might have already collected
> @@ -267,7 +266,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  	 * to an initial measurement/appraisal/audit, but was modified to
>  	 * assume the file changed.
>  	 */
> -	i_version = inode_query_iversion(inode);
>  	hash.hdr.algo = algo;
>  	hash.hdr.length = hash_digest_size[algo];
>  
> @@ -304,7 +302,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  
>  	iint->ima_hash = tmpbuf;
>  	memcpy(iint->ima_hash, &hash, length);
> -	iint->version = i_version;
> +	iint->version = inode_query_iversion(inode);
>  
>  	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
>  	if (!result)

Using the i_version value before calculating the file hash was done
intentionally in case the file changed.

thanks,

Mimi



