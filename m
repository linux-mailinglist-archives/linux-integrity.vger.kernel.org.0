Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF2D664446
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jan 2023 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjAJPPO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Jan 2023 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjAJPPN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Jan 2023 10:15:13 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001471FD
        for <linux-integrity@vger.kernel.org>; Tue, 10 Jan 2023 07:15:11 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEOo3o027069;
        Tue, 10 Jan 2023 15:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=iWWLC20HhOMXRX1y5KDWqFkkgdQMFXHFmtyggCzyfPk=;
 b=C3WymAzqBfRm8dkEPQGvEfN6xnvFr0INOMRFvoTMGhZljyT5E4ra3AmBGKq8jETgceF+
 yF3nm5aidX8OsB28nxOtsdJjanZ5bHIG2lpOIl3SUnPkJZwSjUi7YuDqgua2IUxnoY68
 zGKN2LsEr5XyUr1+cpPcKST+m5SM+vQ3dPsc4k0ng/LVOJAi836orK+rJNx0o3kd2NaL
 f1LcW9Xp058Xc/92AHIv8QJsfGZ5yAkXwacx90svEiYgZBvwCp1cv/lgzPQc8V87Qk4P
 1dykIq5x7WXHcJB+hrD19D/mqZKd/IA/yetm6EE9EOf7HaXFC2KCr7qqhnwNs7QG5MLG 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n19rtscrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:14:50 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AEQqEm000342;
        Tue, 10 Jan 2023 15:14:50 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n19rtscr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:14:49 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AEuWRV008568;
        Tue, 10 Jan 2023 15:14:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3my0c7pvbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 15:14:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AFElvd49480000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 15:14:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9545758054;
        Tue, 10 Jan 2023 15:14:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A69325805A;
        Tue, 10 Jan 2023 15:14:46 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.108.101])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 15:14:46 +0000 (GMT)
Message-ID: <fd70fa2719387961698089af520460beb8f549ea.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 3/8] Compile the UML kernel and download
 it in Github Actions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 10 Jan 2023 10:14:46 -0500
In-Reply-To: <20230109165552.3409716-4-roberto.sassu@huaweicloud.com>
References: <20230109165552.3409716-1-roberto.sassu@huaweicloud.com>
         <20230109165552.3409716-4-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NlDAcToppZTaoyYgDF1Nx_mO3JtK-GBB
X-Proofpoint-ORIG-GUID: WmjIudIgACye20xRiWJypy74Tdw16x47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_06,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

On Mon, 2023-01-09 at 17:55 +0100, Roberto Sassu wrote:
> +          pushd linux-integrity
> +          git pull --depth 5 origin ${{ secrets.LINUX_BRANCH }}
> +          ./scripts/kconfig/merge_config.sh -m .config ../config-uml
> +          make ARCH=um olddefconfig

Should the above two lines be reversed?  First create a .config based
on the default UML config, then update it with the test specific
options - security, integrity, IMA, EVM.

> +          make ARCH=um $CROSS_COMPILE_OPT -j$(nproc)
> +          chmod +x linux
> +          cp linux ..
> +          cp certs/signing_key.pem ..
> +          popd

-- 
thanks,

Mimi

