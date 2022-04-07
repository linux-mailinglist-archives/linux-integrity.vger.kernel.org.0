Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F74F8205
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbiDGOqK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiDGOqJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 10:46:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A995BE08;
        Thu,  7 Apr 2022 07:43:50 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237ELGAi028430;
        Thu, 7 Apr 2022 14:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+62jLIl9fAULYighSKmPmMh9FSeRATooKrDWGxOoe3A=;
 b=ijbmwRaE+AW7S7DEDWrl3oGUVm0B3i35Eq/WBgKiw1i6IdTlNOvYbfpptAhOnylrr5m4
 X7Urvql7wWPqevaewj+WMysozPR6WG+xZ/ZdDonN+CJ69eQFIODEsilVj/mYK2pbm64p
 QOWf4Ek1CkHvyMyXoQs2W7jVrqkcsQ/Rj3rBcSdlq/GXopF8kSNyTqxO1MSe+J5w8YLY
 LqUAIHBV6Dh98N5i/QLL/BfaOGjCfdSjpYAIFCxu85lVqhlHjlirHWk2GeRK9vunmyZo
 S6D6y7IpKXX2iEs6lo+svsuUut1t9SEypywYH6ugb5a0hrfPIb3FYsGySIdwdpEVniKu 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa0by2qsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:43:41 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237ELnr3029884;
        Thu, 7 Apr 2022 14:43:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa0by2qrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:43:41 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237EdPAo022948;
        Thu, 7 Apr 2022 14:43:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3f6e4923bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:43:38 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237Ehah254264072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 14:43:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB315204F;
        Thu,  7 Apr 2022 14:43:36 +0000 (GMT)
Received: from sig-9-65-64-98.ibm.com (unknown [9.65.64.98])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9AB4F5204E;
        Thu,  7 Apr 2022 14:43:35 +0000 (GMT)
Message-ID: <fbc9cda8eacc0a701d7b336bf45ecb6dfd450be9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] ima: remove the IMA_TEMPLATE Kconfig option
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     GUO Zihua <guozihua@huawei.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Apr 2022 10:43:35 -0400
In-Reply-To: <20220407021619.146410-2-guozihua@huawei.com>
References: <20220407021619.146410-1-guozihua@huawei.com>
         <20220407021619.146410-2-guozihua@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vSgQl5agzBeyef9h5Pk1NZZtDf03cPFH
X-Proofpoint-ORIG-GUID: s197i5WVDd1hX7pStpEn5i2CJP-Htyju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_03,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=881 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-04-07 at 10:16 +0800, GUO Zihua wrote:
> The original 'ima' measurement list template contains a hash, defined
> as 20 bytes, and a null terminated pathname, limited to 255
> characters.  Other measurement list templates permit both larger hashes
> and longer pathnames.  When the "ima" template is configured as the
> default, a new measurement list template (ima_template=) must be
> specified before specifying a larger hash algorithm (ima_hash=) on the
> boot command line.
> 
> To avoid this boot command line ordering issue, remove the legacy "ima"
> template configuration option, allowing it to still be specified on the
> boot command line.
> 
> The root cause of this issue is that during the processing of ima_hash,
> we would try to check whether the hash algorithm is compatible with the
> template. If the template is not set at the moment we do the check, we
> check the algorithm against the configured default template. If the
> default template is "ima", then we reject any hash algorithm other than
> sha1 and md5.
> 
> For example, if the compiled default template is "ima", and the default
> algorithm is sha1 (which is the current default). In the cmdline, we put
> in "ima_hash=sha256 ima_template=ima-ng". The expected behavior would be
> that ima starts with ima-ng as the template and sha256 as the hash
> algorithm. However, during the processing of "ima_hash=",
> "ima_template=" has not been processed yet, and hash_setup would check
> the configured hash algorithm against the compiled default: ima, and
> reject sha256. So at the end, the hash algorithm that is actually used
> will be sha1.
> 
> With template "ima" removed from the configured default, we ensure that
> the default tempalte would at least be "ima-ng" which allows for
> basically any hash algorithm.
> 
> This change would not break the algorithm compatibility checks for IMA.
> 
> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

thanks,

Mimi


