Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2A677E39
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Jan 2023 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjAWOkc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 09:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjAWOka (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 09:40:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B922202B
        for <linux-integrity@vger.kernel.org>; Mon, 23 Jan 2023 06:40:27 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NDMnhI019198;
        Mon, 23 Jan 2023 14:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=abkZgWU+vS4e/zI/Gb803wWkOGEkJ1GdiTlQYddplLo=;
 b=i2EV2uU0XnJSWd8pw3Kay36UkpADRYxfcdfP6SuZJ5GclWArWUp6RsvXxXH87sgwK5zy
 ioRhXn/b/bb3WBM1FXfHJkQmBoSzO3mRD8Jh9gHaZZp/3J23+1K8jGy3vFc+DAyQtuAt
 SPCCIS3E7j1ctptWthvpyC3pabFDbpI4KEMDTdcl7aCC1fxGyrk9whs6N4bWU6kB0XXT
 C5f7VQhXETpcUJqOcjmGeU41Tg9Bu+6FczGBXormBQCvtx62MnGXHytTYiM+pTVMhhbe
 01vEBCxGY8ya66YzGL+lLbMusnbj+/c7csl5XenX7jEIIgIbjMfVBWEIPXXTvDkNjjOG tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9u2st66n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 14:40:05 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30NDNMef021489;
        Mon, 23 Jan 2023 14:40:04 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9u2st65m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 14:40:04 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NDkVgs003161;
        Mon, 23 Jan 2023 14:40:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n87p6vvn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 14:40:03 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30NEe24E32375512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 14:40:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2505B5805A;
        Mon, 23 Jan 2023 14:40:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E29B58056;
        Mon, 23 Jan 2023 14:40:01 +0000 (GMT)
Received: from sig-9-77-133-110.ibm.com (unknown [9.77.133.110])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 14:40:01 +0000 (GMT)
Message-ID: <4b39d880d2ddfec667608222d7ca7a0eed5fe28b.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 6/9] Add tests for EVM portable
 signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 23 Jan 2023 09:40:00 -0500
In-Reply-To: <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
         <20230112122426.3759938-7-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3sQakxXrMKwfR4fjBWKZYSkc1XUwowcL
X-Proofpoint-GUID: dkQCSg3rGGo5XVzCBN3-62pOwtpdnERV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_10,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Thu, 2023-01-12 at 13:24 +0100, Roberto Sassu wrote:
> +
> +key_path="/lib/modules/$(uname -r)/source/certs/signing_key.pem"
> +if [ -f "$PWD/../signing_key.pem" ]; then
> +       key_path=$PWD/../signing_key.pem
> +fi
> +

For testing locally, how about first checking the file exists, before
setting key_path?  On not finding it, perhaps check whether
"/lib/modules/$(uname -r)/build/certs/signing_key.pem" exists.

-- 
thanks,

Mimi


