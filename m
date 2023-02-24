Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133436A1F7F
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBXQVX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 11:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXQVW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 11:21:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A47C5E846;
        Fri, 24 Feb 2023 08:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBd93voUUiMLqaY6K+iMCWuD0EYxw+0T9EXxAj7Y+BGSv0SNmbmTpip7Pj62U5rJ34Zatu6U/DqAtWXCBP/YMJozAXTmTxYd773fFxvD8rFGNwTD0F324NDsrPgCwK5KqUbpL8mDMPS6aBzB1xTdFxbTHhPyGk2rdas8HuxvjC8UV5SCHwGiwOEcLpyvy+tv+ch4nD5Pki6pArPF+p8sxCLHOcahSMelyLgH8zf+lhka1YZMrAxD0kA2fLrL3/fqwk4tg3fUeRWUZpHzFRKDcTtu28L7k6jFAMra0rSkFQYcKfiPZtB+pyoWIb4DL34ebVYfZxIQar/wo3sumkvKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWi8GiG0bd5qtZFt9APCldCO+ZFwSNZQZu3tbeXrzs0=;
 b=N21nWb6n1P5cGg9xoY2B3Qgusm8itTVn0H3YXNi184Bzb/vDRE2//+z84hOhC1MuRz97OUGVVy+U7kpdPZdK/eTrwAMujnPJsfZwVaQz0OGZDI8uHACIItpi7yx+ktUKfQgo+mj9hAho/yhtCqAeBrl+mk1HJPqD/7BRIZtOceQ+u3lHwTLQb8Z5mOT2Bj+avzgxOQbbndeKTihtPAfV4FNp84cpBsoCBb9/Z7rXi3U+TEWRLFxDk5NOdNAMLFwS+FfE1R8KuboNU5tpurYcs7aFXghnSz7TWJ0WcslTF+FbBn5HWj70DJFqpzkotEvxsYQ/mOWBcs7VSyCiif0STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWi8GiG0bd5qtZFt9APCldCO+ZFwSNZQZu3tbeXrzs0=;
 b=HQSPE72CHfshZLIORk0xtHZM6siAe+a3iXwEuKUSbi7hBfze4Y86JZguabPL+QcHxz3wwOqQpiWO9caGS/onWNd4tHgG7DE0RQKWdVtxQzKVEd3kKwnGyoWop9KpfEEOnTFcXjG36l7E8hUgOi8sKSusnaYYfPBANFtMnerxM3Gw6cdzn8dHFXI4DXcSdDqUJ8kwoYsGEpP6MpwQTIVYxY+ZE7Bk8knZvJAUfYtdYimc6Ti13Tyx6eycBdPkk1zxb+5bYSvoHZ3ephwaetfiL8NWZM2+KWMOEO2XjXN3BMThrzA0Nm30/LSfJipRlu4C/3ovyUY4OIQBUMQ4qIfGnQ==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 SJ0PR12MB7065.namprd12.prod.outlook.com (2603:10b6:a03:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 16:21:17 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 16:21:17 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Topic: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Index: AQHZR6OqOBQhj0zBTUWL/FYm6RTrP67cxooAgAAUpuCAAALmgIABQ3fwgAAe8YCAAAa28A==
Date:   Fri, 24 Feb 2023 16:21:17 +0000
Message-ID: <DM4PR12MB5769153B42FA57FD98491F6CC3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
 <Y/egACRAp6nKZWdN@sirena.org.uk>
 <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/ezwaFCn5h86u6X@sirena.org.uk>
 <DM4PR12MB5769C60EFD807376CE09DC3FC3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/jdDeBPM//W5WG8@sirena.org.uk>
In-Reply-To: <Y/jdDeBPM//W5WG8@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|SJ0PR12MB7065:EE_
x-ms-office365-filtering-correlation-id: 5b90a38d-fe62-424e-c05c-08db1683280e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDKnNDQV1K/sj2xV/gpm20/WRW0/Syceghru/ibJBQ0BGqFG+61yjkRpV7/xmK0DDOyy1mVTN6DmZt/8UL0MsALBf7QyRQRfbUUKWTcpUyuhae88RJdhUZwWNip61Firr7J9SsmzGAdxqwqKhKrDWidaiCRrYaWaPcruvFHSOT1iOEItE22DiyzSTYu7sjRNrFhoEbOuOJIxV+ZDBUvNF2eOCaRCchjXtiay3mVEg9XAYmZqaxF86PRdC0KEMGtz7pzNfs/owXqoF4wJ4qil/d9v6yNmcbhqcSP0VMmSclHj7faGnhPatzxQ2uUs39dBOcHXdkIL7ZqWWLfUrUVcK86x0Zu0vxTEoKciRpDHGvYquIOAnO8HIvppJS4q6q3ba8MEUy9zd6Bad4tldwr7UmImI86hvCbWYyZkX54VrJGvB4DGKIDfH5ijpU82ro5kMGCvo4bheOxSwCSp0IaLeQd4LysiyQK0JoQhGvrWQ1zWpBhkJfHv0hgfMBAkyvGBe9gq0No2R0t3MjpHFDL9UC7KEkGWx+pjqs+Ol1XnketwY7dE/zvKN5UZffvO0pnuYgsCPQytlg05tNKOH5TzrkGvkMOrhg+iWWeQYfjzfwB7t4tTa+m25TzIx+H7NmyKAn5U6M6+GdVHUldLjdLKgQCRcLJ5V4+f4rGxbVN0nkkpDDTMmBY2idqToen3cHVLC4P1ZDNt7fEcZJ05mZgNYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(122000001)(66899018)(6916009)(66476007)(66946007)(76116006)(66446008)(53546011)(66556008)(8676002)(64756008)(4326008)(55016003)(52536014)(107886003)(41300700001)(38100700002)(9686003)(26005)(7416002)(5660300002)(38070700005)(186003)(71200400001)(7696005)(478600001)(54906003)(6506007)(33656002)(86362001)(2906002)(8936002)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QD2eKem/PavnBGlrYnQIBZHgC2nqc2EXspOvKI+t7X5a0wLYSjOLTLq2EhkV?=
 =?us-ascii?Q?V7vHM+d0/7pHidAcQXpqbkvUbV3dZi7o7SEdMHP1LfY9yONdS9MLMRBqCAo9?=
 =?us-ascii?Q?fTT4B+JK1bI49bF69Bz7kzd/7JS9aXFrHecpUENr26dqwzgGS1kSRjucPsPJ?=
 =?us-ascii?Q?s4XvvGO2lvWHUAmzNlujZA3iOfdR6lERbfckmWQN5cnUh74J4WpXm8LPxM9w?=
 =?us-ascii?Q?nz3GgA60f+xdHsNWVlivc8xfihr7OIMzV5/LLJUuRWkQN/p3gUxSzX05sRe7?=
 =?us-ascii?Q?JJiOUbMeJFYnHD28LmedRmn6xDBUl0wDg3ntklljesIMokaFuU0nlmNSigxf?=
 =?us-ascii?Q?+7S97nSwQdbp6ByxHGi1KGdo0t9TB4xBDLKfqK4MR7C4UshrV3I43YnzRSeI?=
 =?us-ascii?Q?Vg3FPC3zfrzfv5l65nqP8XKkpw1P9ngexXH5LdwupJDGQt5cclgJpUK6AMIE?=
 =?us-ascii?Q?aFrVCdj1XEEmZ1JRRBUx/NNbc/0wIjzOMDdIu8dgW8G3MXfsE4q7CePLWasy?=
 =?us-ascii?Q?RnLJfxac7WPI1BEQ9WgknTONXXi5eUiwdCRzqsfGz1OSJVYSyuZRFWqdbw3i?=
 =?us-ascii?Q?IRauNRRslS/bjN/sMC63TPxJJMafj+RpwPXjlVAycOOpn8wUh2aBcD+WnGZW?=
 =?us-ascii?Q?mK/U9Kftise8KIQuTikw43Djd8WALx/WV6xp0lAy8ZplTjTFKgVGBaw11EsL?=
 =?us-ascii?Q?xgROM1LvvCKEyd2I6XvpDr4WMNPMtWbQy2CMF2nsacABDf3DeWi2N7d0SF6c?=
 =?us-ascii?Q?4RXYVoOxakcblkqiqN8WaXvNFDLvoTSJTLVNRiM9OSzSUF3wdUNp0OGI7I6Z?=
 =?us-ascii?Q?2LflKZaiC2qhLiKAYrFJyIyFB9rC4zeaNH62dl93sBEUM8XkSZlyMoxN5nwy?=
 =?us-ascii?Q?Vi//1YEAeMs/hkJ2kxpQyg1M4bXn4zyEZZRZ31Qzfzsd4DUe2ON05mAVh4Cy?=
 =?us-ascii?Q?yxL1YUENJEGIZ5RV5HM4MAXGlkYFf7W6rErGlINN6Et0k9J/1wWdwLnMQNEC?=
 =?us-ascii?Q?2hvBZLfbYT9+9dwpoKf15GFXE8ec0nq2TPN8Me7xjh1cZj8vuNRLP8X/1rmI?=
 =?us-ascii?Q?zEPP0XisUGASsNXgEAMXAHVjYolgAK5SmdVTMeBxakSlEp2s7otgodGT/70V?=
 =?us-ascii?Q?kDQvtYIiEJZkZDUfyOUK+Hk7mLAAYe8cgNbbioOp9EeD/royK7hTeYehWsow?=
 =?us-ascii?Q?Abv/RhK+qDRj56fI6YmdLnKiGg6QBeAbeA33NXJG27zz3uQcP+EhuTX1F96E?=
 =?us-ascii?Q?f8wFyc3LjAjB7oh0qs5VUIAsc1PTCiyw8noIg5cX+/9E7hDPhIeyJ36nT1Jg?=
 =?us-ascii?Q?NXw7qOGhSMb8ANecSw3rfOxa6a9SJYzEhZZvsRJFR3euST3dZ5NBuKlrGyB6?=
 =?us-ascii?Q?W/C+7+d5EnGB6loDEqxI+NRqlrGmqzGfct+qhUN6RoTw17qMl7IscKzOwFkG?=
 =?us-ascii?Q?AvxaKR1H6Nw/7xQxK+bn+ieDbraQomDN38BUFCYPMgd9noRq5PV+zgWv8A7B?=
 =?us-ascii?Q?MsgpYb1/Wz7q/vS/GvylO4eJz6cmLpWr1QAQENclW50Gvh1W/qoG3x2nwZu8?=
 =?us-ascii?Q?h0S6+UpJcR9bi6UTou9PAea1Si0GbqcR6Q04mJv8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b90a38d-fe62-424e-c05c-08db1683280e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 16:21:17.1014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7HpcKTZLi4AZO8A8a8RBvw3SxKcc3asprNm2Yz7UKGAiKSUJ1zHiK9WhhKs+aGLPABVyN3NQXt6PtrBBKwK6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7065
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 24 February 2023 21:22
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
>=20
> On Fri, Feb 24, 2023 at 02:16:27PM +0000, Krishna Yarlagadda wrote:
>=20
> > > > > > +       spi_bus_lock(phy->spi_device->master);
> > > > > > +
> > > > > > +       while (len) {
>=20
> > > > > Why?
>=20
> > > > TPM supports max 64B in single transaction. Loop to send rest of it=
.
>=20
> > > No, why is there a bus lock?
>=20
> > Bus lock to avoid other clients to be accessed between TPM transfers.
>=20
> That's what a bus lock does but what would be the problem if something
> else sent a message between messages?  Note that a message will always
> be sent atomically.
QSPI has multi-chip-select support. Idea was to prevent transfers from both
devices at the same time. But it should be fine if it is single message.
I will verify with bus lock removed.
